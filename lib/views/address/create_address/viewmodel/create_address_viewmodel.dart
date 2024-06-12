import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import 'package:haydi_express_customer/views/address/create_address/service/create_address_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_geocoder/model/geo_address.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../core/map_manager.dart';

part 'create_address_viewmodel.g.dart';

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
    inputListeners();
  }

  dispose() {
    city.dispose();
    state.dispose();
    neighborhood.dispose();
    street.dispose();
    outDoorNumber.dispose();
    doorNumber.dispose();
    addressDirection.dispose();
    addressName.dispose();
    floor.dispose();
  }

  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController outDoorNumber = TextEditingController();
  final TextEditingController doorNumber = TextEditingController();
  final TextEditingController floor = TextEditingController();
  final TextEditingController addressDirection = TextEditingController();
  final TextEditingController addressName = TextEditingController();

  final CreateAddressService service = CreateAddressService();

  BaseViewModel? anotherViewModelInstance;

  final MapSearchManager searchManager = MapSearchManager();
  final MapController mapController = MapController();

  List provinceData = [];

  @observable
  double mapHeight = 250;

  @observable
  double currentLat = 38.7568597;
  @observable
  double currentLong = 30.5387044;
  bool isOnMapSelection = false;

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

  inputListeners() {
    List<TextEditingController> inputs = [city, state, neighborhood, street];
    for (TextEditingController input in inputs) {
      input.addListener(
        () async {
          if (input.text.isNotEmpty && !isOnMapSelection) {
            await getGeoCodeWithAddress();
            changePlaceMarkerState(
              searchManager.lat ?? currentLat,
              searchManager.long ?? currentLong,
            );
            mapController.move(
                LatLng(currentLat, currentLong), mapController.camera.zoom);
          }
        },
      );
    }
  }

  @action
  changeMapExtend() {
    if (mapHeight <= 250) {
      mapHeight = 500;
    } else {
      mapHeight = 250;
    }
  }

  Future<void> getGeoCodeWithAddress() async {
    return await searchManager.getFromAddress(
      address: GeoLatLang(
        name: "${city.text},${state.text},${neighborhood.text},${street.text}",
      ),
    );
  }

  Future<void> _fetchAddressFromGeoCode() async {
    await searchManager.getAddressWithLatLang(currentLat, currentLong);
    Map<String, String?> addressData =
        _fetchAddressAsJson(searchManager.address?.displayName ?? "");
    neighborhood.text = addressData["neighborhood"] ?? "";
    street.text = addressData["street"] ?? "";
  }

  Map<String, String?> _fetchAddressAsJson(String fullAddress) {
    List<String> slicedAddress = fullAddress.split(",");

    return {
      "neighborhood": slicedAddress[1],
      "street": slicedAddress[0],
    };
  }

  Future<void> onMapTap(double lat, double long) async {
    isOnMapSelection = true;
    changePlaceMarkerState(lat, long);
    await _fetchAddressFromGeoCode();
    isOnMapSelection = false;
  }

  @action
  changePlaceMarkerState(double lat, double long) {
    currentLat = lat;
    currentLong = long;
  }

  bool get _inputValidation {
    if (city.text.isEmpty) {
      showErrorDialog("Şehir Seçiniz.");
      return false;
    }
    if (state.text.isEmpty) {
      showErrorDialog("İlçe Seçiniz.");
      return false;
    }
    if (neighborhood.text.isEmpty) {
      showErrorDialog("Mahalle Giriniz.");
      return false;
    }
    if (street.text.isEmpty) {
      showErrorDialog("Sokak Giriniz.");
      return false;
    }
    if (outDoorNumber.text.isEmpty) {
      showErrorDialog("Bina Numarası Giriniz.");
      return false;
    }
    if (doorNumber.text.isEmpty) {
      showErrorDialog("Daire Numarası Giriniz.");
      return false;
    }
    if (floor.text.isEmpty) {
      showErrorDialog("Kat Bilgisi Giriniz.");
      return false;
    }
    if (addressDirection.text.isEmpty) {
      showErrorDialog("Adresinizi Tarif Ediniz.");
      return false;
    }
    if (addressName.text.isEmpty) {
      showErrorDialog("Lütfen adresinize bir isim giriniz.");
      return false;
    }
    return true;
  }

  Future<void> createAddress() async {
    if (_inputValidation) {
      final bool response =
          await service.createAddress(_fetchAddressModel, accessToken!);
      if (!response) {
        showErrorDialog();
        return;
      }
      navigatorPop();
      navigatorPop();
      showSuccessDialog("Adres başarıyla eklendi");
      await cacheNewAddress();
    }
  }

  Future<void> cacheNewAddress() async {
    List<dynamic>? addresses =
        localeManager.getNullableJsonData(LocaleKeysEnums.addresses.name);
    if (addresses != null) {
      addresses.add(_fetchAddressModel.toJson());
    } else {
      addresses = [_fetchAddressModel.toJson()];
    }

    await localeManager.setJsonData(LocaleKeysEnums.addresses.name, addresses);
  }

  AddressModel get _fetchAddressModel => AddressModel(
        name: addressName.text,
        city: city.text,
        state: state.text,
        neighborhood: neighborhood.text,
        street: street.text,
        buildingNumber: outDoorNumber.text,
        doorNumber: doorNumber.text,
        floor: floor.text,
        addressDirection: addressDirection.text,
        isVerifiedFromCourier: false,
        uid: const Uuid().v8(),
        addressOwner: localeManager.getStringData(LocaleKeysEnums.id.name),
        lat: searchManager.lat,
        long: searchManager.long,
      );
}
