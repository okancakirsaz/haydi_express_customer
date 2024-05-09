import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/authentication/models/customer_model.dart';
import 'package:haydi_express_customer/views/authentication/sign_up/service/sign_up_service.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/init/model/http_exception_model.dart';
import '../../log_in/viewmodel/log_in_viewmodel.dart';
import '../../models/mail_verification_model.dart';
import '../../models/mail_verification_request_model.dart';
import '../view/sign_up_view.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final SignUpService service = SignUpService();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController nameSurname = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController verifyCode = TextEditingController();

  final List<String> steps = [
    "E-Posta & Şifre",
    "Kişisel Bilgiler",
    "E-Posta Onay",
  ];

  @observable
  bool isPoliciesAccepted = false;

  @observable
  bool isAgreementAccepted = false;

  @observable
  Widget currentBody = const SizedBox();

  @observable
  int stepperIndex = 1;

  @observable
  int pageContainerExpand = 3;

  @action
  changeExpand(int newExpand) {
    pageContainerExpand = newExpand;
  }

  @action
  setCurrentBody(Widget widget, int currentIndex, [bool? validation]) {
    if (validation ?? true) {
      currentBody = widget;
      stepperIndex = currentIndex;
    }
  }

  @action
  setCheckboxState(bool data, {required bool isPolicies}) {
    if (isPolicies) {
      isPoliciesAccepted = data;
    } else {
      isAgreementAccepted = data;
    }
  }

  bool get validateSimpleInputs {
    if (email.text.isEmpty && !email.text.contains("@")) {
      showErrorDialog("Lütfen geçerli bir mail adresi giriniz.");
      return false;
    } else if (password.text.isEmpty) {
      showErrorDialog("Lütfen geçerli bir şifre giriniz.");
      return false;
    } else if (!isAgreementAccepted || !isPoliciesAccepted) {
      showErrorDialog(
          "Kullanıcı sözleşmesi ve gizlilik politikasını kabul etmeden kayıt olamazsınız.");
      return false;
    } else {
      return true;
    }
  }

  bool get validatePersonalInputs {
    if (nameSurname.text.isEmpty && gender.text.isNotEmpty) {
      showErrorDialog("Lütfen istenilen bilgilerin girildiğinden emin olunuz.");
      return false;
    } else if (phoneNumber.text.length < 10) {
      showErrorDialog("Lütfen geçerli bir telefon numarası giriniz.");
      return false;
    } else {
      return true;
    }
  }

  Future<void> sendMailVerifyRequest(SignUpViewModel viewModel) async {
    if (validatePersonalInputs) {
      final MailVerificationRequestModel? response =
          await service.sendVerifyRequest(
        MailVerificationRequestModel(
            email: email.text, isMailSent: false, verificationCode: null),
      );
      _handleMailVerifyResponse(response, viewModel);
    }
  }

  _handleMailVerifyResponse(
      MailVerificationRequestModel? response, SignUpViewModel viewModel) {
    if (response != null) {
      if (response.isMailSent) {
        viewModel.setCurrentBody(
          MailVerify(viewModel: viewModel),
          3,
        );
      } else {
        showErrorDialog();
      }
    } else {
      showErrorDialog();
    }
  }

  Future<void> sendVerifyCode(String code) async {
    final MailVerificationModel? response = await service.verifyMailCode(
      MailVerificationModel(
          email: email.text, isCodeTrue: false, verificationCode: code),
    );
    await _handleSendVerifyCodeResponse(response);
  }

  Future<void> _handleSendVerifyCodeResponse(
      MailVerificationModel? response) async {
    if (response != null) {
      if (response.isCodeTrue) {
        await _signUp();
      } else {
        showErrorDialog("Girilen kod yanlış tekrar deneyiniz.");
      }
    } else {
      showErrorDialog();
    }
  }

  Future<void> _signUp() async {
    final dynamic response = await service.signUp(_fetchSignUpData);
    if (response != null) {
      if (response is HttpExceptionModel) {
        showErrorDialog(response.message);
        navigatorPop();
      } else {
        await _tryToLogIn();
      }
    } else {
      showErrorDialog();
    }
  }

  Future<void> _tryToLogIn() async {
    //Dependency Injection
    final LogInViewModel loginViewModel = LogInViewModel();
    loginViewModel.setContext(viewModelContext);
    await loginViewModel.tryToLogIn(email.text, password.text);
  }

  CustomerModel get _fetchSignUpData => CustomerModel(
        email: email.text,
        password: password.text,
        isAgreementsAccepted: true,
        name: nameSurname.text,
        phoneNumber: "+90${phoneNumber.text}",
        gender: gender.text,
        isPhoneVerified: false,
        uid: const Uuid().v7(),
      );
}
