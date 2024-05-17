// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on _MainViewModelBase, Store {
  late final _$currentPageAtom =
      Atom(name: '_MainViewModelBase.currentPage', context: context);

  @override
  Widget get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(Widget value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_MainViewModelBaseActionController =
      ActionController(name: '_MainViewModelBase', context: context);

  @override
  dynamic changePage(Widget newPage) {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changePage');
    try {
      return super.changePage(newPage);
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
