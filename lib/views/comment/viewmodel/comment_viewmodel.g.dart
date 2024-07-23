// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommentViewModel on _CommentViewModelBase, Store {
  late final _$selectedStarCountAtom =
      Atom(name: '_CommentViewModelBase.selectedStarCount', context: context);

  @override
  double get selectedStarCount {
    _$selectedStarCountAtom.reportRead();
    return super.selectedStarCount;
  }

  @override
  set selectedStarCount(double value) {
    _$selectedStarCountAtom.reportWrite(value, super.selectedStarCount, () {
      super.selectedStarCount = value;
    });
  }

  late final _$_CommentViewModelBaseActionController =
      ActionController(name: '_CommentViewModelBase', context: context);

  @override
  dynamic changeStarsValue(double val) {
    final _$actionInfo = _$_CommentViewModelBaseActionController.startAction(
        name: '_CommentViewModelBase.changeStarsValue');
    try {
      return super.changeStarsValue(val);
    } finally {
      _$_CommentViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedStarCount: ${selectedStarCount}
    ''';
  }
}
