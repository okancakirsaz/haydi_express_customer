import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'addresses_viewmodel.g.dart';

class AddressesViewModel = _AddressesViewModelBase with _$AddressesViewModel;

abstract class _AddressesViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final AddressesService service = AddressesService();

  List<AddressModel> addresses = [];

  Future<int> getAddresses() async {
    try {
      await bringDataFromCacheOrApi(
        LocaleKeysEnums.addresses.name,
        getFromApi: () async => await _getAddressFromApi(),
        getFromCache: () => _getAddressFromCache(),
      );
      return 1;
    } catch (e) {
      debugPrint("$e");
      return -1;
    }
  }

  Future<void> _getAddressFromApi() async {
    final List<AddressModel>? response = await service.getUserAddresses(
        localeManager.getStringData(LocaleKeysEnums.id.name), accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    addresses = response;
  }

  _getAddressFromCache() {
    final List<dynamic> cachedList =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name) ?? [];
    addresses = cachedList.map((e) => AddressModel.fromJson(e)).toList();
  }
}
