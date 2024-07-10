import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import 'package:haydi_express_customer/views/create_order/bucket/model/bucket_element_model.dart';
import 'package:haydi_express_customer/views/create_order/core/constants/payment_methods.dart';
import 'package:haydi_express_customer/views/create_order/core/models/card_model.dart';
import 'package:haydi_express_customer/views/create_order/order_steps/view/order_steps_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/widgets/dialog/are_you_sure_dialog.dart';
import '../service/order_steps_service.dart';

part 'order_steps_viewmodel.g.dart';

class OrderStepsViewModel = _OrderStepsViewModelBase with _$OrderStepsViewModel;

abstract class _OrderStepsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    getCachedCardData();
  }

  getTotalPrice(int data) => totalPrice = data;

  int totalPrice = 0;
  final TextEditingController note = TextEditingController();
  final OrderStepsService service = OrderStepsService();

  final List<String> steps = [
    "Adres Bilgileri",
    "Ödeme Yöntemi",
    "Sipariş Detay"
  ];

  //Addresses

  final AddressesService addressesService = AddressesService();
  List<AddressModel> addresses = [];

  AddressModel? chosenAddress;

  Future<List<AddressModel>> getAddresses() async {
    bringDataFromCacheOrApi(
      LocaleKeysEnums.addresses.name,
      getFromApi: () async => _getAddressFromApi(),
      getFromCache: () => _getAddressFromCache(),
    );
    return addresses;
  }

  Future<void> _getAddressFromApi() async {
    final List<AddressModel>? response =
        await addressesService.getUserAddresses(
            localeManager.getStringData(LocaleKeysEnums.id.name), accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    addresses = response;
  }

  _getAddressFromCache() {
    final List<dynamic> cachedList =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name) ?? [];
    addresses = cachedList.map((e) => AddressModel.fromJson(e)).toList();
  }

  String fetchAddressToUi(AddressModel data) {
    return '${data.name} - ${data.city}/${data.state}-${data.neighborhood},${data.street},Bina No: ${data.buildingNumber},Kat: ${data.floor},Daire: ${data.doorNumber}';
  }

  chooseAddress(AddressModel data, OrderStepsViewModel viewModel) {
    chosenAddress = data;
    navigationManager.navigate(PaymentMethod(viewModel: viewModel));
  }

  //Payment methods

  PaymentMethods? chosenMethod;

  choosePaymentMethod(PaymentMethods method, OrderStepsViewModel viewModel) {
    chosenMethod = method;
    if (method == PaymentMethods.online) {
      navigationManager.navigate(OnlinePayment(viewModel: viewModel));
    } else {
      navigationManager.navigate(OrderDetails(viewModel: viewModel));
    }
  }

  //Online Payment
  @observable
  String cardNumber = "";
  @observable
  String cardHolderName = "";
  @observable
  String expireDate = "";
  @observable
  String cvvCode = "";
  @observable
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumber = creditCardModel.cardNumber;
    expireDate = creditCardModel.expiryDate;
    cardHolderName = creditCardModel.cardHolderName;
    cvvCode = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
  }

  CardModel get _fetchCardModel => CardModel(
      cardNumber: cardNumber,
      expireDate: expireDate,
      cardHolder: cardHolderName,
      cvv: cvvCode);

  getCachedCardData() {
    final Map<String, dynamic>? rawValue =
        localeManager.getNullableJsonData(LocaleKeysEnums.creditCard.name);
    if (rawValue != null) {
      final CardModel cardData = CardModel.fromJson(rawValue);
      cardNumber = cardData.cardNumber;
      cardHolderName = cardData.cardHolder;
      cvvCode = cardData.cvv;
      expireDate = cardData.expireDate;
    }
  }

  Future<void> goToDetailsPage(OrderStepsViewModel viewModel) async {
    await _openCardSaveDialog();
    navigationManager.navigate(OrderDetails(viewModel: viewModel));
  }

  Future<void> _openCardSaveDialog() async {
    if (localeManager.getNullableJsonData(LocaleKeysEnums.creditCard.name) ==
        null) {
      await showDialog(
        context: viewModelContext,
        builder: (context) => AreYouSure(
          onPressed: _saveLocaleToCardData,
          description: Text(
              "Bilgiler cihazınızın içinde tutulup kimse ile paylaşılmayacaktır.",
              style: TextConsts.instance.regularWhite14),
          question: "Kart bilgilerini kaydetmek ister misiniz?",
        ),
      );
    }
  }

  Future<void> _saveLocaleToCardData() async {
    await localeManager.setJsonData(
      LocaleKeysEnums.creditCard.name,
      _fetchCardModel.toJson(),
    );
    navigatorPop();
  }

  //Details

  List<Widget> get fetchBucketToDetails {
    List<BucketElementModel> bucket = _getBucket;
    List<Widget> bucketAsWidget = bucket
        .map(
          (e) => OrderDetailsBucketElement(
              menuName: e.menuElement.name,
              price: e.menuElement.isOnDiscount
                  ? calculateDiscount(
                      e.menuElement.price, e.menuElement.discountAmount!)
                  : e.menuElement.price,
              count: e.count),
        )
        .toList();
    return bucketAsWidget;
  }

  List<BucketElementModel> get _getBucket =>
      (localeManager.getJsonData(LocaleKeysEnums.bucket.name) as List<dynamic>)
          .map((e) => BucketElementModel.fromJson(e))
          .toList();

  Future<bool> checkIsAnyRestaurantUsesHe() async {
    List<BucketElementModel> bucket = _getBucket;
    List<String> ids = bucket.map((e) => e.menuElement.restaurantUid).toList();
    List result = await _isRestaurantsUsesHe(ids);
    if (result.contains(false) || result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List> _isRestaurantsUsesHe(List<String> ids) async {
    final List response =
        await service.isRestaurantsUsesHe(ids, accessToken!) ?? [];
    return response;
  }
}
