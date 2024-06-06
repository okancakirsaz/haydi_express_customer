import 'package:flutter/material.dart';
import 'package:open_geocoder/model/geo_address.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as yandex;
import 'package:yandex_maps_mapkit_lite/image.dart' as image_provider;

import '../../../core/consts/asset_consts.dart';
import 'managers/map_manager.dart';

part 'map_viewmodel.g.dart';

class MapViewModel = _MapViewModelBase with _$MapViewModel;

abstract class _MapViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  yandex.MapWindow? mapWindow;
  yandex.PlacemarkMapObject? placeMark;
  final LayersGeoObjectTapListenerImpl mapTapListener =
      LayersGeoObjectTapListenerImpl();
  MapInputListenerImpl? mapInputListener;
  final MapCameraListenerImpl cameraListener = MapCameraListenerImpl();

  dispose() {
    mapWindow!.map.removeCameraListener(cameraListener);
    mapWindow!.map.removeInputListener(mapInputListener!);
    mapWindow!.map.removeTapListener(mapTapListener);
  }

  mapInit(yandex.MapWindow _) {
    mapWindow = _;
    mapWindow!.map.move(cameraListener.currentCamPosition);
    _setPlaceMark();
    mapInputListener = MapInputListenerImpl(placeMark: placeMark!);
    _initMapListeners();
  }

  _setPlaceMark() {
    placeMark = mapWindow!.map.mapObjects.addPlacemark()
      ..geometry = cameraListener.currentCamPosition.target
      ..setIcon(
        image_provider.ImageProvider.fromImageProvider(
          AssetImage(AssetConsts.instance.placeMark),
        ),
      );
  }

  _initMapListeners() {
    mapWindow!.map.addCameraListener(cameraListener);
    mapWindow!.map.addTapListener(mapTapListener);
    mapWindow!.map.addInputListener(mapInputListener!);
  }

  //TODO: Get from address inputs
  getGeoCodeWithAddress() {
    MapSearchManager.getFromAddress(
      address: GeoLatLang(
        address: Address(neighbourHood: "Dumlupınar Mahallesi"),
      ),
    );
  }
}
