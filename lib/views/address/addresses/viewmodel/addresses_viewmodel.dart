import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/addresses/service/addresses_service.dart';
import 'package:haydi_express_customer/views/address/create_edit_address/view/create_edit_address_view.dart';
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

  @observable
  ObservableList<AddressModel> addresses = ObservableList.of([]);

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
    addresses = ObservableList.of(response);
  }

  _getAddressFromCache() {
    final List<dynamic> cachedList =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name) ?? [];
    addresses = ObservableList.of(
      cachedList.map((e) => AddressModel.fromJson(e)).toList(),
    );
  }

  @action
  Future<void> deleteAddress(String addressId) async {
    showWaitDialog();
    final bool? response = await service.deleteAddress(addressId, accessToken!);
    if (response == false || response == null) {
      showErrorDialog();
      return;
    }

    AddressModel deletedAddress =
        addresses.firstWhere((element) => element.uid == addressId);
    int deletedAddressIndex = addresses.indexOf(deletedAddress);
    addresses.removeAt(deletedAddressIndex);

    await localeManager.setJsonData(
      LocaleKeysEnums.addresses.name,
      addresses.map((element) => element.toJson()).toList(),
    );

    navigatorPop();
  }

  showWaitDialog() {
    showDialog(
      context: viewModelContext,
      builder: (context) => AlertDialog(
        content: Text(
          "Lütfen Bekleyiniz...",
          style: TextConsts.instance.regularBlack16,
        ),
      ),
    );
  }

  navigateToEditAddress(AddressModel address) {
    navigationManager.navigate(CreateEditAddressView(
      data: address,
    ));
  }
}
