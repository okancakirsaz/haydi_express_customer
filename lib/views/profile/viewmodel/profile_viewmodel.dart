import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_ekspres_dev_tools/models/http_exception_model.dart';
import 'package:haydi_ekspres_dev_tools/models/models_index.dart';
import 'package:haydi_ekspres_dev_tools/models/order_model.dart';
import 'package:haydi_ekspres_dev_tools/models/personal_value_types.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/widgets/dialog/are_you_sure_dialog.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:haydi_express_customer/views/authentication/log_in/view/log_in_view.dart';
import 'package:haydi_express_customer/views/landing_view/viewmodel/landing_viewmodel.dart';
import 'package:haydi_express_customer/views/profile/service/profile_service.dart';
import 'package:intl/intl.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import '../view/profile_view.dart';

part 'profile_viewmodel.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    _initPersonalData();
  }

  final ProfileService service = ProfileService();

  String get id => localeManager.getStringData(LocaleKeysEnums.id.name);

  final TextEditingController nameSurname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController cancelReason = TextEditingController();

  @observable
  ObservableList<OrderModel> activeOrders = ObservableList.of([]);

  @observable
  ObservableList<OrderModel> orderHistory = ObservableList.of([]);

  _initPersonalData() {
    nameSurname.text =
        localeManager.getStringData(LocaleKeysEnums.nameSurname.name);
    email.text = localeManager.getStringData(LocaleKeysEnums.email.name);
    phoneNumber.text =
        localeManager.getStringData(LocaleKeysEnums.phoneNumber.name);
  }

  Future<void> deleteCardData() async {
    await localeManager.removeData(LocaleKeysEnums.creditCard.name);
    showSuccessDialog("Kayıtlı kredi kartı verileri başarıyla silindi.");
  }

  Future<void> logOut() async {
    await localeManager.removeData(LocaleKeysEnums.id.name);
    await localeManager.removeData(LocaleKeysEnums.orderLogs.name);
    navigationManager.navigateAndRemoveUntil(const LogInView());
  }

  Future<void> changePassword() async {
    final ForgotPasswordViewModel forgotPasswordVm = ForgotPasswordViewModel();
    forgotPasswordVm.viewModelContext = viewModelContext;
    forgotPasswordVm.email.text =
        localeManager.getStringData(LocaleKeysEnums.email.name);
    await forgotPasswordVm.sendResetPasswordMail();
  }

  Future<void> changePersonalValue(PersonalValueTypes type) async {
    String newValue = "";
    switch (type) {
      case PersonalValueTypes.email:
        newValue = email.text;
        break;
      case PersonalValueTypes.phoneNumber:
        newValue = phoneNumber.text.contains("+90")
            ? phoneNumber.text
            : phoneNumber.text[0] == "0"
                ? "+9${phoneNumber.text}"
                : "+90${phoneNumber.text}";
        break;
      case PersonalValueTypes.nameSurname:
        newValue = nameSurname.text;
        break;
    }
    if (newValue.isEmpty) {
      showErrorDialog("Lütfen gerekli yerleri doldurunuz.");
      return;
    }
    final response = await service.changePersonalValue(
      id,
      newValue,
      type.name,
      accessToken!,
    );

    if (response == null || response is HttpExceptionModel) {
      showErrorDialog();
      return;
    }

    await localeManager.removeData(type.name);
    await localeManager.setStringData(type.name, newValue);
    showSuccessDialog();
  }

  showAreYouSureDialog() {
    showDialog(
      context: viewModelContext,
      builder: (context) => AreYouSure(
        description: Text(
          "Tüm verileriniz kalıcı olarak silinecektir.",
          style: TextConsts.instance.regularWhite16,
        ),
        onPressed: () async => await _deleteAccount(),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    final response = await service.deleteAccount(
      id,
      accessToken!,
    );
    if (response == null) {
      showErrorDialog();
      return;
    }
    if (response is HttpExceptionModel) {
      showErrorDialog(response.message);
      return;
    }
    await LandingViewModel().clearCache();
    await logOut();
  }

  @action
  Future<bool> getActiveOrders() async {
    final List<OrderModel>? response =
        await service.getActiveOrders(id, accessToken!);
    if (response == null) {
      showErrorDialog();
      return false;
    }
    activeOrders = ObservableList.of(response);
    return true;
  }

  @action
  Future<bool> getOrderLogs() async {
    try {
      bringDataFromCacheOrApi(LocaleKeysEnums.orderLogs.name,
          getFromApi: () async {
        final List<OrderModel>? response =
            await service.getOrderLogs(id, accessToken!);
        if (response == null) {
          showErrorDialog();
          return;
        }
        orderHistory = ObservableList.of(response);
        await localeManager.setJsonData(LocaleKeysEnums.orderLogs.name,
            orderHistory.map((e) => e.toJson()).toList());
      }, getFromCache: () {
        orderHistory = ObservableList.of(
            (localeManager.getJsonData(LocaleKeysEnums.orderLogs.name) as List)
                .map((e) => OrderModel.fromJson(e))
                .toList());
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  String parseIso8601DateFormatDetailed(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    String hourFormat = DateFormat('HH.mm').format(dateTime);
    String dateFormat = DateFormat('dd.MM.yyyy').format(dateTime);
    return "$hourFormat - $dateFormat";
  }

  String fetchMenuPrice(BucketElementModel bucketElement) {
    return "${bucketElement.menuElement.isOnDiscount ? calculateDiscount(bucketElement.menuElement.price, bucketElement.menuElement.discountAmount!) : (bucketElement.menuElement.price * bucketElement.count)}₺";
  }

  openOrderCancelDialog(ProfileViewModel viewModel, OrderModel data) {
    showDialog(
      context: viewModelContext,
      builder: (context) => CancelReasonDialog(
        viewModel: viewModel,
        data: data,
      ),
    );
  }

  @action
  Future<void> cancelOrder(OrderModel data) async {
    if (_isOrderSuitableToCancel(data.orderState.asOrderState)) {
      data.orderState = Cancelled.instance.text;
      final dynamic response = await service.cancelOrder(
          CancelOrderModel(
            order: data,
            reason: cancelReason.text,
          ),
          accessToken!);
      if (response == null) {
        showErrorDialog();
        return;
      }
      if (response is HttpExceptionModel) {
        showErrorDialog(response.message);
        return;
      }
    }
    activeOrders.removeAt(getActiveOrderIndex(data.orderId));
    //Change order logs
    orderHistory.add(data);
    await localeManager.setJsonData(LocaleKeysEnums.orderLogs.name,
        orderHistory.map((e) => e.toJson()).toList());
    //Close dialog
    navigatorPop();
  }

  int getActiveOrderIndex(String orderId) {
    return activeOrders.indexWhere((e) => e.orderId == orderId);
  }

  int getOrderHistoryIndex(String orderId) {
    return orderHistory.indexWhere((e) => e.orderId == orderId);
  }

  bool _isOrderSuitableToCancel(OrderState state) {
    if (state == CourierIsOnWay.instance ||
        state == PackageIsOnWay.instance ||
        state == PackageDelivered.instance) {
      showErrorDialog(state.text);
      return false;
    } else {
      return true;
    }
  }
}
