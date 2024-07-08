// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on _MenuViewModelBase, Store {
  late final _$counterAtom =
      Atom(name: '_MenuViewModelBase.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$_MenuViewModelBaseActionController =
      ActionController(name: '_MenuViewModelBase', context: context);

  @override
  dynamic changeCounterState(bool isIncrement) {
    final _$actionInfo = _$_MenuViewModelBaseActionController.startAction(
        name: '_MenuViewModelBase.changeCounterState');
    try {
      return super.changeCounterState(isIncrement);
    } finally {
      _$_MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
