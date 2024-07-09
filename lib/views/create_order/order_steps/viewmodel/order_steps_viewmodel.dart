import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'order_steps_viewmodel.g.dart';

class OrderStepsViewModel = _OrderStepsViewModelBase with _$OrderStepsViewModel;

abstract class _OrderStepsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  final List<String> steps = [
    "Adres Bilgileri",
    "Ödeme Yöntemi",
    "Sipariş Detay"
  ];

  final AddressesService addressesService = AddressesService();
  List<AddressModel> addresses = [];

  Future<List<AddressModel>> getAddresses() async {
    bringDataFromCacheOrApi(
      LocaleKeysEnums.addresses.name,
      getFromApi: () async => _getAddressFromApi(),
      getFromCache: () => _getAddressFromCache(),
    );
    return addresses;
  }

  Future<void> _getAddressFromApi() async {
    final List<AddressModel>? response =
        await addressesService.getUserAddresses(
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

  String fetchAddressToUi(AddressModel data) {
    return '''
    ${data.name}
    ${data.city}/${data.state}-${data.neighborhood},${data.street},Bina No: ${data.buildingNumber},Kat: ${data.floor},Daire: ${data.doorNumber}
    ''';
  }
}
