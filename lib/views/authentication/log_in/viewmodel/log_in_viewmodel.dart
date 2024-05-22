import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/services/public_service.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/view/forgot_password_view.dart';
import 'package:haydi_express_customer/views/authentication/log_in/service/log_in_service.dart';
import 'package:haydi_express_customer/views/authentication/models/log_in_model.dart';
import 'package:haydi_express_customer/views/authentication/sign_up/view/sign_up_view.dart';
import 'package:haydi_express_customer/views/main_view/view/main_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'log_in_viewmodel.g.dart';

class LogInViewModel = _LogInViewModelBase with _$LogInViewModel;

abstract class _LogInViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final LogInService service = LogInService();
  final PublicService publicService = PublicService();

  List<MenuModel> haydiFirsatlar = [];

  navigateToForgotPassword() {
    navigationManager.navigate(const ForgotPasswordView());
  }

  navigateToSignUp() {
    navigationManager.navigate(const SignUpView());
  }

  _navigateToMainPage() {
    navigationManager.navigateAndRemoveUntil(const MainView());
  }

  Future<void> tryToLogIn(String mail, String pass) async {
    if (mail.isEmpty || pass.isEmpty || !mail.contains("@")) {
      showErrorDialog("E-Posta veya şifre giriniz.");
      return;
    }

    final LogInModel? response = await _sendLogInRequest(mail, pass);

    if (response == null) {
      showErrorDialog();
      return;
    }

    if (!response.isLoginSuccess) {
      showErrorDialog(response.unSuccessfulReason);
      return;
    }
    await _cacheUserData(response);
    _navigateToMainPage();
  }

  Future<LogInModel?> _sendLogInRequest(String mail, String pass) async {
    final LogInModel? response = await service.logIn(LogInModel(
      mail: mail,
      password: pass,
      isLoginSuccess: false,
    ));
    return response;
  }

  Future<void> _cacheUserData(LogInModel response) async {
    await localeManager.setStringData(LocaleKeysEnums.id.name, response.uid!);
    await localeManager.setStringData(
        LocaleKeysEnums.accessToken.name, response.accessToken!);
    await localeManager.setStringData(
        LocaleKeysEnums.password.name, response.password);
    await localeManager.setStringData(
        LocaleKeysEnums.email.name, response.mail);
  }

  Future<List<MenuModel>?> _getAdvertsFromApi() async {
    final List<MenuModel>? response =
        await publicService.getAdvertedMenu(AppConst.instance.haydiFirsatlar);
    if (response == null && kDebugMode) {
      showErrorDialog("Haydi Fırsatlar getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  Future<int> fetchAdverts() async {
    await bringDataFromCacheOrApi(LocaleKeysEnums.haydiFirsatlar.name,
        getFromApi: () async {
      final List<MenuModel>? dataFromApi = await _getAdvertsFromApi();
      await localeManager.setNullableJsonData(
          LocaleKeysEnums.haydiFirsatlar.name,
          dataFromApi?.map((e) => e.toJson()).toList());
      haydiFirsatlar = dataFromApi ?? [];
    }, getFromCache: () {
      final List<dynamic> cachedData =
          localeManager.getJsonData(LocaleKeysEnums.haydiFirsatlar.name);
      for (Map<String, dynamic> data in cachedData) {
        haydiFirsatlar.add(MenuModel.fromJson(data));
      }
    });
    return 1;
  }
}
