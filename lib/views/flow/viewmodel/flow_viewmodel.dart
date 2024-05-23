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
  init() {
    checkIsUserHaveAnyAddress(viewModelInstance);
  }

  late final FlowViewModel viewModelInstance;

  List<MenuModel> haydiFirsatlar = [];
  final PublicService publicService = PublicService();

  Future<List<MenuModel>?> _getAdvertsFromApi() async {
    final List<MenuModel>? response =
        await publicService.getAdvertedMenu(AppConst.instance.haydiFirsatlar);
    if (response == null && kDebugMode) {
      showErrorDialog("Haydi Fırsatlar getirilirken bir sorun oluştu");
      return null;
    }
    return response;
  }

  //TODO: *REVIEW* Do this function more growable
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