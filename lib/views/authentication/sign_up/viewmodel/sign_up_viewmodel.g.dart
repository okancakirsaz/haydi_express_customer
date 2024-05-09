// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpViewModel on _SignUpViewModelBase, Store {
  late final _$isPoliciesAcceptedAtom =
      Atom(name: '_SignUpViewModelBase.isPoliciesAccepted', context: context);

  @override
  bool get isPoliciesAccepted {
    _$isPoliciesAcceptedAtom.reportRead();
    return super.isPoliciesAccepted;
  }

  @override
  set isPoliciesAccepted(bool value) {
    _$isPoliciesAcceptedAtom.reportWrite(value, super.isPoliciesAccepted, () {
      super.isPoliciesAccepted = value;
    });
  }

  late final _$isAgreementAcceptedAtom =
      Atom(name: '_SignUpViewModelBase.isAgreementAccepted', context: context);

  @override
  bool get isAgreementAccepted {
    _$isAgreementAcceptedAtom.reportRead();
    return super.isAgreementAccepted;
  }

  @override
  set isAgreementAccepted(bool value) {
    _$isAgreementAcceptedAtom.reportWrite(value, super.isAgreementAccepted, () {
      super.isAgreementAccepted = value;
    });
  }

  late final _$currentBodyAtom =
      Atom(name: '_SignUpViewModelBase.currentBody', context: context);

  @override
  Widget get currentBody {
    _$currentBodyAtom.reportRead();
    return super.currentBody;
  }

  @override
  set currentBody(Widget value) {
    _$currentBodyAtom.reportWrite(value, super.currentBody, () {
      super.currentBody = value;
    });
  }

  late final _$stepperIndexAtom =
      Atom(name: '_SignUpViewModelBase.stepperIndex', context: context);

  @override
  int get stepperIndex {
    _$stepperIndexAtom.reportRead();
    return super.stepperIndex;
  }

  @override
  set stepperIndex(int value) {
    _$stepperIndexAtom.reportWrite(value, super.stepperIndex, () {
      super.stepperIndex = value;
    });
  }

  late final _$pageContainerExpandAtom =
      Atom(name: '_SignUpViewModelBase.pageContainerExpand', context: context);

  @override
  int get pageContainerExpand {
    _$pageContainerExpandAtom.reportRead();
    return super.pageContainerExpand;
  }

  @override
  set pageContainerExpand(int value) {
    _$pageContainerExpandAtom.reportWrite(value, super.pageContainerExpand, () {
      super.pageContainerExpand = value;
    });
  }

  late final _$_SignUpViewModelBaseActionController =
      ActionController(name: '_SignUpViewModelBase', context: context);

  @override
  dynamic changeExpand(int newExpand) {
    final _$actionInfo = _$_SignUpViewModelBaseActionController.startAction(
        name: '_SignUpViewModelBase.changeExpand');
    try {
      return super.changeExpand(newExpand);
    } finally {
      _$_SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentBody(Widget widget, int currentIndex, [bool? validation]) {
    final _$actionInfo = _$_SignUpViewModelBaseActionController.startAction(
        name: '_SignUpViewModelBase.setCurrentBody');
    try {
      return super.setCurrentBody(widget, currentIndex, validation);
    } finally {
      _$_SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCheckboxState(bool data, {required bool isPolicies}) {
    final _$actionInfo = _$_SignUpViewModelBaseActionController.startAction(
        name: '_SignUpViewModelBase.setCheckboxState');
    try {
      return super.setCheckboxState(data, isPolicies: isPolicies);
    } finally {
      _$_SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPoliciesAccepted: ${isPoliciesAccepted},
isAgreementAccepted: ${isAgreementAccepted},
currentBody: ${currentBody},
stepperIndex: ${stepperIndex},
pageContainerExpand: ${pageContainerExpand}
    ''';
  }
}
