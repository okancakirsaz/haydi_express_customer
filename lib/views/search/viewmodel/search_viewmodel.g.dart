// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchViewModel on _SearchViewModelBase, Store {
  late final _$searchBarHintAtom =
      Atom(name: '_SearchViewModelBase.searchBarHint', context: context);

  @override
  String get searchBarHint {
    _$searchBarHintAtom.reportRead();
    return super.searchBarHint;
  }

  @override
  set searchBarHint(String value) {
    _$searchBarHintAtom.reportWrite(value, super.searchBarHint, () {
      super.searchBarHint = value;
    });
  }

  late final _$suggestionsAtom =
      Atom(name: '_SearchViewModelBase.suggestions', context: context);

  @override
  ObservableList<SuggestionModel> get suggestions {
    _$suggestionsAtom.reportRead();
    return super.suggestions;
  }

  @override
  set suggestions(ObservableList<SuggestionModel> value) {
    _$suggestionsAtom.reportWrite(value, super.suggestions, () {
      super.suggestions = value;
    });
  }

  late final _$changeSearchBarHintAsyncAction =
      AsyncAction('_SearchViewModelBase.changeSearchBarHint', context: context);

  @override
  Future<void> changeSearchBarHint() {
    return _$changeSearchBarHintAsyncAction
        .run(() => super.changeSearchBarHint());
  }

  @override
  String toString() {
    return '''
searchBarHint: ${searchBarHint},
suggestions: ${suggestions}
    ''';
  }
}
