import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/authentication/forgot_password/service/forgot_password_service.dart';
import 'package:haydi_express_customer/views/authentication/log_in/view/log_in_view.dart';
import 'package:haydi_express_customer/views/authentication/models/forgot_password_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../sign_up/view/sign_up_view.dart';

part 'forgot_password_viewmodel.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final ForgotPasswordService service = ForgotPasswordService();
  final TextEditingController email = TextEditingController();

  navigateLogIn() {
    navigationManager.navigate(const LogInView());
  }

  navigateToSignUp() {
    navigationManager.navigate(const SignUpView());
  }

  Future<void> sendResetPasswordMail() async {
    if (email.text != "") {
      final ForgotPasswordModel? response = await service.forgotPassword(
        ForgotPasswordModel(
          isMailSent: false,
          mail: email.text,
          uid: "",
        ),
      );

      if (response == null) {
        showErrorDialog("Bir sorun oluştu, tekrar deneyiniz.");
      } else {
        if (response.isMailSent) {
          navigateLogIn();
          showErrorDialog("E-Postanızı kontrol ediniz.");
        } else {
          showErrorDialog("Lütfen geçerli bir e-posta adresi giriniz.");
        }
      }
    } else {
      showErrorDialog("Lütfen geçerli bir e-posta adresi giriniz.");
    }
  }
}
