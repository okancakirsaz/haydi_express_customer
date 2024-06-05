import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:haydi_express_customer/core/consts/asset_consts.dart';
import 'package:haydi_express_customer/views/address/core/map_manager.dart';
import 'package:haydi_express_customer/views/address/create_address/service/create_address_service.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as yandex;
// ignore: implementation_imports
import 'package:yandex_maps_mapkit_lite/image.dart' as image_provider;
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'create_address_viewmodel.g.dart';

//import 'package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart'
class CreateAddressViewModel = _CreateAddressViewModelBase
    with _$CreateAddressViewModel;

abstract class _CreateAddressViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    showNotificationDialog();
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
    mapWindow!.map.removeCameraListener(cameraListener);
  }

  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController outDoorNumber = TextEditingController();
  final TextEditingController doorNumber = TextEditingController();
  final TextEditingController addressDirection = TextEditingController();

  final CreateAddressService service = CreateAddressService();
  yandex.MapWindow? mapWindow;

  final MapObjectTapListenerImpl mapTapListener = MapObjectTapListenerImpl();
  final MapCameraListenerImpl cameraListener = MapCameraListenerImpl();
  List provinceData = [];

  @observable
  double mapHeight = 250;

  @observable
  ObservableList<DropdownMenuEntry> cityDropdownItems = ObservableList.of([]);
  @observable
  ObservableList<DropdownMenuEntry> stateDropdownItems = ObservableList.of([]);

  showNotificationDialog() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showSuccessDialog("Doğru Adres = Sıcak Yemek");
    });
  }

  mapInit(yandex.MapWindow _) {
    mapWindow = _;
    mapWindow!.map.move(cameraListener.currentCamPosition);
    initMapListeners();
    final yandex.PlacemarkMapObject placeMark =
        mapWindow!.map.mapObjects.addPlacemark()
          ..geometry = cameraListener.currentCamPosition.target
          ..setIcon(
            image_provider.ImageProvider.fromImageProvider(
              AssetImage(AssetConsts.instance.placeMark),
            ),
          );
    placeMark.addTapListener(mapTapListener);
    //TODO: Set placemark state
  }

  initMapListeners() {
    mapWindow!.map.addCameraListener(cameraListener);
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

  @action
  changeMapExtend() {
    if (mapHeight <= 250) {
      mapHeight = 500;
    } else {
      mapHeight = 250;
    }
  }
}
