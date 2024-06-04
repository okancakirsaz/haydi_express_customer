import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:haydi_express_customer/views/address/create_address/service/create_address_service.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'create_address_viewmodel.g.dart';

class CreateAddressViewModel = _CreateAddressViewModelBase
    with _$CreateAddressViewModel;

abstract class _CreateAddressViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    showNotificationDialog();
    mapkit.onStart();
    await getProvinceJson();
    fetchCityAsDropdownMenuItem();
    fetchStatesAsDropdownMenuItem();
  }

  dispose() {
    city.dispose();
    state.dispose();
    neighborhood.dispose();
    street.dispose();
    outDoorNumber.dispose();
    doorNumber.dispose();
    addressDirection.dispose();
  }

  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController outDoorNumber = TextEditingController();
  final TextEditingController doorNumber = TextEditingController();
  final TextEditingController addressDirection = TextEditingController();

  final CreateAddressService service = CreateAddressService();
  MapWindow? mapWindow;
  List provinceData = [];

  @observable
  ObservableList<DropdownMenuEntry> cityDropdownItems = ObservableList.of([]);
  @observable
  ObservableList<DropdownMenuEntry> stateDropdownItems = ObservableList.of([]);

  showNotificationDialog() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showSuccessDialog("Doğru Adres = Sıcak Yemek");
    });
  }

  Future<List> getProvinceJson() async {
    final String jsonFile =
        await rootBundle.loadString('assets/meta/turkey.json');
    provinceData = jsonDecode(jsonFile);
    return provinceData;
  }

  @action
  fetchCityAsDropdownMenuItem() {
    cityDropdownItems = ObservableList.of(provinceData
        .map((e) => DropdownMenuEntry(value: e["city"], label: e["city"]))
        .toList());
  }

  @action
  fetchStatesAsDropdownMenuItem() {
    city.addListener(() {
      for (int i = 0; i <= provinceData.length - 1; i++) {
        if (city.text == provinceData[i]["city"]) {
          List states = provinceData[i]["states"];
          stateDropdownItems = ObservableList.of(states
              .map((e) => DropdownMenuEntry(value: e, label: e))
              .toList());
          break;
        }
      }
    });
  }
}
