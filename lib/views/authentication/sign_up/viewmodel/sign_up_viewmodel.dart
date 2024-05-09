import 'package:flutter/material.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'sign_up_viewmodel.g.dart';

class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

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
}
