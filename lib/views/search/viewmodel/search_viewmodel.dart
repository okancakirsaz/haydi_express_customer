import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/search/service/search_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/cache/local_keys_enums.dart';
import '../../../core/init/model/suggestion_model.dart';
import '../view/search_view.dart';

part 'search_viewmodel.g.dart';

class SearchViewModel = _SearchViewModelBase with _$SearchViewModel;

abstract class _SearchViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    //await localeManager.removeData(LocaleKeysEnums.favSuggestions.name);
    _initSuggestions();
    await changeSearchBarHint();
  }

  final SearchService service = SearchService();
  @observable
  String searchBarHint = "";

  @observable
  ObservableList<SuggestionModel> suggestions = ObservableList.of([]);

  List<String> searchBarHints = [
    "Restoran Adı",
    "Örn: Gülyurt",
    "Menü Adı",
    "Örn: BigMac Menü",
    "Anahtar Kelime",
    "Örn: Döner"
  ];

  @action
  Future<void> changeSearchBarHint() async {
    for (String hint in searchBarHints) {
      await Future.delayed(const Duration(milliseconds: 1000));
      searchBarHint = "";
      for (int i = 0; i <= hint.length - 1; i++) {
        searchBarHint += hint[i];
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  _initSuggestions() async {
    List<SuggestionModel> favSuggestions = _getFavSuggestions();

    await bringDataFromCacheOrApi(
      LocaleKeysEnums.advertSuggestions.name,
      getFromApi: () async {
        List<SuggestionModel> suggestionsFromApi = await getSearchAds();
        suggestions = ObservableList.of(suggestionsFromApi + favSuggestions);
      },
      getFromCache: () {
        List<SuggestionModel> advertSuggestions =
            _getAdvertedSuggestionsFromCache();
        suggestions = ObservableList.of(advertSuggestions + favSuggestions);
      },
    );
  }

  Future<List<SuggestionModel>> getSearchAds() async {
    final List<SuggestionModel>? response =
        await service.getSearchAds(accessToken!);
    if (response == null) {
      return [];
    }

    List<Map<String, dynamic>> responseRaw = [];

    responseRaw = response.map((e) => e.toJson()).toList();

    await localeManager.setJsonData(
        LocaleKeysEnums.advertSuggestions.name, responseRaw);
    return response;
  }

  Future<void> search(String keyword, SearchViewModel viewModel) async {
    if (keyword.isEmpty || keyword.length < 2 || keyword.trim().isEmpty) {
      return;
    }

    List<SuggestionModel> params = await _searchRequest(keyword);
    navigationManager.navigate(SearchPage(
        viewModel: viewModel, suggestions: params, keyword: keyword));
  }

  Future<List<SuggestionModel>> _searchRequest(String keyword) async {
    final List<SuggestionModel>? response =
        await service.search(keyword, accessToken!);
    if (response == null) {
      showErrorDialog();
      return [];
    } else {
      return response;
    }
  }

  //TODO: Complete this function.
  Future<void> onSuggestionTap(SuggestionModel data) async {
    await _setNewFavSuggestion(data);
  }

  Future<void> _setNewFavSuggestion(SuggestionModel data) async {
    final List<dynamic> cachedSuggestions = localeManager
            .getNullableJsonData(LocaleKeysEnums.favSuggestions.name) ??
        [];
    final List<SuggestionModel> cachedSugsAsModel =
        cachedSuggestions.map((e) => SuggestionModel.fromJson(e)).toList();

    final bool isDataExist = cachedSugsAsModel
        .where((element) => element.elementId == data.elementId)
        .isNotEmpty;

    if (!isDataExist && !data.isBoosted) {
      cachedSuggestions.add(data.toJson());
      await localeManager.setJsonData(
          LocaleKeysEnums.favSuggestions.name, cachedSuggestions);
    }
  }

  List<SuggestionModel> _getFavSuggestions() {
    final List<dynamic> cachedSuggestions = localeManager
            .getNullableJsonData(LocaleKeysEnums.favSuggestions.name) ??
        [];
    return cachedSuggestions.map((e) => SuggestionModel.fromJson(e)).toList();
  }

  List<SuggestionModel> _getAdvertedSuggestionsFromCache() {
    List<dynamic> suggestionsRaw = localeManager
            .getNullableJsonData(LocaleKeysEnums.advertSuggestions.name) ??
        [];
    return suggestionsRaw.map((e) => SuggestionModel.fromJson(e)).toList();
  }
}
