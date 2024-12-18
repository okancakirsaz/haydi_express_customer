import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/services/public_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'category_list_viewmodel.g.dart';

class CategoryListViewModel = _CategoryListViewModelBase
    with _$CategoryListViewModel;

abstract class _CategoryListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    _initCategoryLocaleKey();
  }

  String category = "";
  String categoryLocaleKey = "";

  @observable
  ObservableList<MenuModel> dataList = ObservableList.of([]);

  bool isCategoryAdvert = false;
  final PublicService publicService = PublicService();

  _initCategoryLocaleKey() {
    if (category == AppConst.instance.haydiFirsatlar) {
      categoryLocaleKey = LocaleKeysEnums.haydiFirsatlar.name;
      isCategoryAdvert = true;
      return;
    }

    if (category == AppConst.instance.discover) {
      categoryLocaleKey = LocaleKeysEnums.discover.name;
      isCategoryAdvert = false;
      return;
    }
  }

  Future<List<MenuModel>?> _getAdvertsFromApi() async {
    final List<MenuModel>? response = await publicService.getAdvertedMenu(
      category,
    );
    if (response == null && kDebugMode) {
      showErrorDialog("$category getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  Future<List<MenuModel>> _getMoreMenuFromApi() async {
    final List<MenuModel>? response = await publicService.getMoreDiscoverMenu(
        dataList.last.stats.likeRatio, accessToken!);
    if (response == null && kDebugMode) {
      showErrorDialog("Daha fazla $category getirilirken bir sorun oluştu");
      return [];
    }
    return response ?? [];
  }

  Future<List<MenuModel>> _getMoreAdvertsFromApi() async {
    final List<MenuModel>? response = await publicService.getMoreAdvertedMenu(
        category, dataList.last.boostExpireDate!, accessToken!);
    if (response == null && kDebugMode) {
      showErrorDialog("Daha fazla $category getirilirken bir sorun oluştu");
      return [];
    }
    return response ?? [];
  }

  Future<List<MenuModel>?> _getMenuFromApi() async {
    final List<MenuModel>? response =
        await publicService.getDiscoverMenu(accessToken!);
    if (response == null && kDebugMode) {
      showErrorDialog("$category getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  Future<List<MenuModel>> fetchData() async {
    await bringDataFromCacheOrApi(categoryLocaleKey, getFromApi: () async {
      final List<MenuModel>? dataFromApi = isCategoryAdvert
          ? await _getAdvertsFromApi()
          : await _getMenuFromApi();
      await _setLocaleToMenu(dataFromApi);
      dataList = ObservableList.of(dataFromApi ?? []);
    }, getFromCache: () {
      final List<dynamic> cachedData =
          localeManager.getJsonData(categoryLocaleKey);
      for (Map<String, dynamic> data in cachedData) {
        dataList.add(MenuModel.fromJson(data));
      }
    });
    return dataList;
  }

  Future<void> _setLocaleToMenu(List<MenuModel>? dataFromApi) async {
    await localeManager.setNullableJsonData(
        categoryLocaleKey, dataFromApi?.map((e) => e.toJson()).toList());
  }

  @action
  Future<List<MenuModel>> fetchMoreData() async {
    final List<MenuModel> dataFromApi = isCategoryAdvert
        ? await _getMoreAdvertsFromApi()
        : await _getMoreMenuFromApi();
    if (dataFromApi.isEmpty) {
      showErrorDialog("Daha fazla menü bulunmamakta.");
    }
    dataList = ObservableList.of(dataList + dataFromApi);
    await _setLocaleToMenu(dataList);
    return dataList;
  }
}
