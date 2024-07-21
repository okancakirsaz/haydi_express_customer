import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_ekspres_dev_tools/models/card_model.dart';
import 'package:haydi_ekspres_dev_tools/models/http_exception_model.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:haydi_ekspres_dev_tools/models/payment_methods.dart';
import 'package:haydi_ekspres_dev_tools/models/payment_model.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/addresses/viewmodel/addresses_viewmodel.dart';
import 'package:haydi_express_customer/views/create_order/order_steps/view/order_steps_view.dart';
import 'package:haydi_express_customer/views/main_view/view/main_view.dart';
import 'package:uuid/uuid.dart';
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
    final AddressesViewModel addressesVm = AddressesViewModel();
    await addressesVm.getAddresses();
    addresses = addressesVm.addresses;
    return addresses;
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
        cvv: cvvCode,
      );

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
    if (formKey.currentState?.validate() ?? false) {
      await _openCardSaveDialog();
      navigationManager.navigate(OrderDetails(viewModel: viewModel));
    } else {
      showErrorDialog("Lütfen istenilen bilgileri eksiksiz giriniz.");
    }
  }

  @action
  Future<void> deleteSavedCardData() async {
    await localeManager.removeData(LocaleKeysEnums.creditCard.name);
    cardHolderName = "";
    cardNumber = "";
    cvvCode = "";
    expireDate = "";
  }

  Future<void> _openCardSaveDialog() async {
    if (localeManager.getNullableJsonData(LocaleKeysEnums.creditCard.name) ==
            null &&
        (formKey.currentState?.validate() ?? false)) {
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
    //Close dialog
    navigatorPop();
  }

  //Details
  String usesHeRestaurantNames = "";

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
    List<String> checkedRestaurantNames = [];
    if (result.contains(true)) {
      for (int i = 0; i <= result.length - 1; i++) {
        String restaurantName = bucket[i].menuElement.restaurantName;
        if (!checkedRestaurantNames.contains(restaurantName)) {
          usesHeRestaurantNames += "$restaurantName, ";
          checkedRestaurantNames.add(restaurantName);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  Future<List> _isRestaurantsUsesHe(List<String> ids) async {
    final List response =
        await service.isRestaurantsUsesHe(ids, accessToken!) ?? [];
    return response;
  }

  //Create order
  OrderModel _fetchOrderModel(String restaurantId, String restaurantName,
          int price, List<BucketElementModel> menuData) =>
      OrderModel(
        paymentData: PaymentModel(
          cardData: chosenMethod == PaymentMethods.online
              ? CardModel(
                  cardHolder: cardHolderName,
                  cardNumber: cardNumber,
                  cvv: cvvCode,
                  expireDate: expireDate)
              : null,
          totalPrice: price,
        ),
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        customerId: localeManager.getStringData(LocaleKeysEnums.id.name),
        menuData: menuData,
        addressData: chosenAddress!,
        paymentMethod: chosenMethod!.value,
        isPaidSuccess: chosenMethod == PaymentMethods.online ? false : null,
        orderState: "Restoran Onayı Bekleniyor",
        orderCreationDate: DateTime.now().toIso8601String(),
        customerName:
            localeManager.getStringData(LocaleKeysEnums.nameSurname.name),
        customerPhoneNumber:
            localeManager.getStringData(LocaleKeysEnums.phoneNumber.name),
        note: note.text,
        orderId: const Uuid().v1(),
      );

  //This function creates a order instance for every different restaurant
  Future<void> fetchOrders(OrderStepsViewModel viewModel) async {
    //Get all bucket
    List<BucketElementModel> bucket =
        (localeManager.getJsonData(LocaleKeysEnums.bucket.name) as List)
            .map((e) => (BucketElementModel.fromJson(e)))
            .toList();
    //Separate restaurant ID's and names
    List<String> idList =
        bucket.map((e) => e.menuElement.restaurantUid).toList();
    List<String> nameList =
        bucket.map((e) => e.menuElement.restaurantName).toList();
    List<String> checkedIdsList = [];
    for (int i = 0; i <= bucket.length - 1; i++) {
      //Check is restaurant order fetched
      if (!checkedIdsList.contains(idList[i])) {
        //Get restaurant bucket
        List<BucketElementModel> restaurantBucket = bucket
            .where((e) => e.menuElement.restaurantUid == idList[i])
            .toList();
        int price = restaurantBucket
            .map(
              (e) => (e.count *
                  (e.menuElement.isOnDiscount
                      ? calculateDiscount(
                          e.menuElement.price, e.menuElement.discountAmount!)
                      : e.menuElement.price)),
            )
            .toList()
            .reduce((a, b) => a + b);
        await _createOrder(
          idList[i],
          nameList[i],
          price,
          restaurantBucket,
          viewModel,
        );
        checkedIdsList.add(idList[i]);
      }
    }
  }

  Future<void> _createOrder(
      String restaurantId,
      String restaurantName,
      int price,
      List<BucketElementModel> menuData,
      OrderStepsViewModel viewModel) async {
    final response = await service.createOrder(
      _fetchOrderModel(restaurantId, restaurantName, price, menuData),
      accessToken!,
    );
    bool isSuccess = false;
    if (response == null) {
      isSuccess = false;
      return;
    }
    if (response is HttpExceptionModel) {
      isSuccess = false;
    } else {
      isSuccess = true;
    }
    navigationManager.navigate(
      OrderStepsFinalPage(
        isSuccess: isSuccess,
        viewModel: viewModel,
        errorReason: isSuccess == false
            ? (response as HttpExceptionModel).message
            : null,
      ),
    );
  }

  Future<void> returnToMainView() async {
    await localeManager.removeData(LocaleKeysEnums.bucket.name);
    navigationManager.navigate(const MainView());
  }
}
