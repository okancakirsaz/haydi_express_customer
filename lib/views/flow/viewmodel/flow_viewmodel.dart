import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/services/public_service.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'flow_viewmodel.g.dart';

class FlowViewModel = _FlowViewModelBase with _$FlowViewModel;

abstract class _FlowViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  initViewModelInstance(FlowViewModel model) => viewModelInstance = model;

  @override
  init() async {
    checkIsUserHaveAnyAddress(viewModelInstance);
    await changeSearchBarHint();
  }

  late final FlowViewModel viewModelInstance;

  List<MenuModel> haydiFirsatlar = [];
  List<MenuModel> discover = [];
  final PublicService publicService = PublicService();

  @observable
  String searchBarHint = "";

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

  Future<List<MenuModel>?> _getAdvertsFromApi() async {
    final List<MenuModel>? response =
        await publicService.getAdvertedMenu(AppConst.instance.haydiFirsatlar);
    if (response == null && kDebugMode) {
      showErrorDialog("Haydi Fırsatlar getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  Future<List<MenuModel>?> _getDiscoverFromApi() async {
    final List<MenuModel>? response =
        await publicService.getDiscoverMenu(accessToken!);
    if (response == null && kDebugMode) {
      showErrorDialog("Ne Yesem getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  Future<List<MenuModel>> fetchHaydiFirsatlar() async {
    await bringDataFromCacheOrApi(LocaleKeysEnums.haydiFirsatlar.name,
        getFromApi: () async {
      final List<MenuModel>? dataFromApi = await _getAdvertsFromApi();
      await localeManager.setNullableJsonData(
          LocaleKeysEnums.haydiFirsatlar.name,
          dataFromApi?.map((e) => e.toJson()).toList());
      haydiFirsatlar = dataFromApi ?? [];
    }, getFromCache: () {
      final List<dynamic> cachedData =
          localeManager.getJsonData(LocaleKeysEnums.haydiFirsatlar.name);
      for (Map<String, dynamic> data in cachedData) {
        haydiFirsatlar.add(MenuModel.fromJson(data));
      }
    });
    return haydiFirsatlar;
  }

  Future<List<MenuModel>> fetchDiscover() async {
    await bringDataFromCacheOrApi(LocaleKeysEnums.discover.name,
        getFromApi: () async {
      final List<MenuModel>? dataFromApi = await _getDiscoverFromApi();
      await localeManager.setNullableJsonData(LocaleKeysEnums.discover.name,
          dataFromApi?.map((e) => e.toJson()).toList());
      discover = dataFromApi ?? [];
    }, getFromCache: () {
      final List<dynamic> cachedData =
          localeManager.getJsonData(LocaleKeysEnums.discover.name);
      for (Map<String, dynamic> data in cachedData) {
        discover.add(MenuModel.fromJson(data));
      }
    });
    return discover;
  }

  checkIsUserHaveAnyAddress(FlowViewModel viewModel) {
    final addresses =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name);
    //TODO: If addresses is null in cache.
    //Try to look database. Then if is null show bottom sheet
    if (addresses == null) {
      //Wait for build page
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showBottomSheet(
            context: viewModelContext,
            builder: (context) =>
                CreateAddressBottomSheet(viewModel: viewModel));
      });
    }
  }

  navigateToSeeAll(String category, Widget page) {
    navigationManager.navigate(page);
  }
}
