// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_steps_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderStepsViewModel on _OrderStepsViewModelBase, Store {
  late final _$cardNumberAtom =
      Atom(name: '_OrderStepsViewModelBase.cardNumber', context: context);

  @override
  String get cardNumber {
    _$cardNumberAtom.reportRead();
    return super.cardNumber;
  }

  @override
  set cardNumber(String value) {
    _$cardNumberAtom.reportWrite(value, super.cardNumber, () {
      super.cardNumber = value;
    });
  }

  late final _$cardHolderNameAtom =
      Atom(name: '_OrderStepsViewModelBase.cardHolderName', context: context);

  @override
  String get cardHolderName {
    _$cardHolderNameAtom.reportRead();
    return super.cardHolderName;
  }

  @override
  set cardHolderName(String value) {
    _$cardHolderNameAtom.reportWrite(value, super.cardHolderName, () {
      super.cardHolderName = value;
    });
  }

  late final _$expireDateAtom =
      Atom(name: '_OrderStepsViewModelBase.expireDate', context: context);

  @override
  String get expireDate {
    _$expireDateAtom.reportRead();
    return super.expireDate;
  }

  @override
  set expireDate(String value) {
    _$expireDateAtom.reportWrite(value, super.expireDate, () {
      super.expireDate = value;
    });
  }

  late final _$cvvCodeAtom =
      Atom(name: '_OrderStepsViewModelBase.cvvCode', context: context);

  @override
  String get cvvCode {
    _$cvvCodeAtom.reportRead();
    return super.cvvCode;
  }

  @override
  set cvvCode(String value) {
    _$cvvCodeAtom.reportWrite(value, super.cvvCode, () {
      super.cvvCode = value;
    });
  }

  late final _$isCvvFocusedAtom =
      Atom(name: '_OrderStepsViewModelBase.isCvvFocused', context: context);

  @override
  bool get isCvvFocused {
    _$isCvvFocusedAtom.reportRead();
    return super.isCvvFocused;
  }

  @override
  set isCvvFocused(bool value) {
    _$isCvvFocusedAtom.reportWrite(value, super.isCvvFocused, () {
      super.isCvvFocused = value;
    });
  }

  late final _$_OrderStepsViewModelBaseActionController =
      ActionController(name: '_OrderStepsViewModelBase', context: context);

  @override
  dynamic onCreditCardModelChange(CreditCardModel creditCardModel) {
    final _$actionInfo = _$_OrderStepsViewModelBaseActionController.startAction(
        name: '_OrderStepsViewModelBase.onCreditCardModelChange');
    try {
      return super.onCreditCardModelChange(creditCardModel);
    } finally {
      _$_OrderStepsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cardNumber: ${cardNumber},
cardHolderName: ${cardHolderName},
expireDate: ${expireDate},
cvvCode: ${cvvCode},
isCvvFocused: ${isCvvFocused}
    ''';
  }
}
