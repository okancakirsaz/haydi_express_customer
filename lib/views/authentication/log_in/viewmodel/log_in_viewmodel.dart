import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/view/forgot_password_view.dart';
import 'package:haydi_express_customer/views/authentication/log_in/service/log_in_service.dart';
import 'package:haydi_express_customer/views/authentication/models/log_in_model.dart';
import 'package:haydi_express_customer/views/authentication/sign_up/view/sign_up_view.dart';
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

  navigateToForgotPassword() {
    navigationManager.navigate(const ForgotPasswordView());
  }

  navigateToSignUp() {
    navigationManager.navigate(const SignUpView());
  }

  _navigateToMainPage() {
    //TODO: Implement main page
    navigationManager.navigateAndRemoveUntil(const Scaffold());
  }

  Future<void> tryToLogIn(String mail, String pass) async {
    if (mail != "" && pass != "") {
      final LogInModel response = await _sendLogInRequest(mail, pass);

      if (response.isLoginSuccess) {
        await localeManager.setStringData(
            LocaleKeysEnums.id.name, response.uid!);
        _navigateToMainPage();
      } else {
        showErrorDialog(response.unSuccessfulReason);
      }
    } else {
      showErrorDialog("E-Posta veya şifre eksik.");
    }
  }

  Future<LogInModel> _sendLogInRequest(String mail, String pass) async {
    final LogInModel? response = await service.logIn(LogInModel(
      mail: mail,
      password: pass,
      isLoginSuccess: false,
    ));
    if (response == null) {
      showErrorDialog("Bir sorun oluştu, tekrar deneyiniz.");
      throw Exception("Response is null");
    }
    return response;
  }
}
