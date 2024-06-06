import 'package:flutter/material.dart';
import 'package:open_geocoder/model/geo_address.dart';
import 'package:open_geocoder/model/geo_data.dart';
import 'package:open_geocoder/open_geocoder.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';

final class MapSearchManager {
  GeoLatLang? address;
  double? lat;
  double? long;
  MapSearchManager.getFromAddress({required this.address}) {
    getGeoCodeWithAddress();
  }
  MapSearchManager.getFromGeoCode({required this.lat, required this.long}) {
    getAddressWithLatLang();
  }

  Future<void> getAddressWithLatLang() async {
    GeoLatLang? geoLatLang = await OpenGeocoder.getAddressWithLatLong(
        latitude: lat!, longitude: long!);
    if (geoLatLang != null) {
      address = geoLatLang;
      debugPrint(address!.displayName);
    }
  }

  Future<void> getGeoCodeWithAddress() async {
    List<GeoData> addressesList = await OpenGeocoder.getAddressesWithName(
        name: "${address!.address!.neighbourHood}");
    if (addressesList.isNotEmpty) {
      lat = double.parse(addressesList[0].latitude!);
      long = double.parse(addressesList[0].longitude!);
      debugPrint('$lat,$long');
    }
  }
}

final class MapCameraListenerImpl implements MapCameraListener {
  //Default value is initial value(Afyonkarahisar)
  CameraPosition currentCamPosition = const CameraPosition(
      Point(latitude: 38.7634, longitude: 30.5408),
      zoom: 10,
      azimuth: 1,
      tilt: 1);

  @override
  void onCameraPositionChanged(Map map, CameraPosition cameraPosition,
      CameraUpdateReason cameraUpdateReason, bool finished) {
    currentCamPosition = cameraPosition;
  }
}

final class LayersGeoObjectTapListenerImpl
    implements LayersGeoObjectTapListener {
  @override
  bool onObjectTap(GeoObjectTapEvent event) {
    return true;
  }
}

final class MapInputListenerImpl implements MapInputListener {
  final PlacemarkMapObject placeMark;
  MapInputListenerImpl({required this.placeMark});
  @override
  void onMapLongTap(Map map, Point point) {}

  @override
  void onMapTap(Map map, Point point) {
    MapSearchManager.getFromGeoCode(lat: point.latitude, long: point.longitude);
    placeMark.geometry = point;
  }
}
