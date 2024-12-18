// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_app_bar_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomAppBarViewModel on _CustomAppBarViewModelBase, Store {
  late final _$pageIndexAtom =
      Atom(name: '_CustomAppBarViewModelBase.pageIndex', context: context);

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  late final _$_CustomAppBarViewModelBaseActionController =
      ActionController(name: '_CustomAppBarViewModelBase', context: context);

  @override
  dynamic changePage(Widget page, int index) {
    final _$actionInfo = _$_CustomAppBarViewModelBaseActionController
        .startAction(name: '_CustomAppBarViewModelBase.changePage');
    try {
      return super.changePage(page, index);
    } finally {
      _$_CustomAppBarViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageIndex: ${pageIndex}
    ''';
  }
}
