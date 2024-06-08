import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/services/public_service.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import 'package:haydi_express_customer/views/flow/service/flow_service.dart';
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
    await checkIsUserHaveAnyAddress(viewModelInstance);
  }

  late final FlowViewModel viewModelInstance;

  List<MenuModel> haydiFirsatlar = [];
  List<MenuModel> discover = [];

  final PublicService publicService = PublicService();
  final FlowService service = FlowService();
  final AddressesService addressService = AddressesService();

  Future<List<MenuModel>?> _getAdvertsFromApi() async {
    final List<MenuModel>? response =
        await publicService.getAdvertedMenu(AppConst.instance.haydiFirsatlar);
    if (response == null) {
      kDebugMode
          ? showErrorDialog("Haydi Fırsatlar getirilirken bir sorun oluştu")
          : null;
      return null;
    }
    return response;
  }

  Future<List<MenuModel>?> _getDiscoverFromApi() async {
    final List<MenuModel>? response =
        await publicService.getDiscoverMenu(accessToken!);
    if (response == null) {
      kDebugMode
          ? showErrorDialog("Ne Yesem getirilirken bir sorun oluştu")
          : null;
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

  Future<void> checkIsUserHaveAnyAddress(FlowViewModel viewModel) async {
    await bringDataFromCacheOrApi(
      LocaleKeysEnums.addresses.name,
      getFromApi: () async {
        await _getUserAddressesFromApi();
      },
      getFromCache: () {
        //Nothing
      },
    );
    final List<dynamic>? addresses =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name);
    if (addresses == [] || addresses == null) {
      _buildCreateAddressSheet(viewModel);
    }
  }

  Future<void> _getUserAddressesFromApi() async {
    final List<AddressModel>? response = await addressService.getUserAddresses(
      localeManager.getStringData(LocaleKeysEnums.id.name),
      accessToken!,
    );
    if (response == null || response.isEmpty) {
      debugPrint("User addresses is empty");
      return;
    }
    await localeManager.setJsonData(
      LocaleKeysEnums.addresses.name,
      response
          .map(
            (e) => e.toJson(),
          )
          .toList(),
    );
  }

  _buildCreateAddressSheet(FlowViewModel viewModel) {
    //Wait for build page
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showBottomSheet(
          context: viewModelContext,
          builder: (context) => CreateAddressBottomSheet(viewModel: viewModel));
    });
  }

  navigateToSeeAll(String category, Widget page) {
    navigationManager.navigate(page);
  }
}
