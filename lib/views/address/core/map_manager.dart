import 'package:flutter/material.dart';
import 'package:open_geocoder/model/geo_address.dart';
import 'package:open_geocoder/model/geo_data.dart';
import 'package:open_geocoder/open_geocoder.dart';

final class MapSearchManager {
  GeoLatLang? address;
  double? lat;
  double? long;
  Future<void> getFromAddress({required GeoLatLang address}) async {
    await getGeoCodeWithAddress(address);
  }

  Future<void> getFromGeoCode(
      {required double lat, required double long}) async {
    await getAddressWithLatLang(lat, long);
  }

  Future<void> getAddressWithLatLang(double cLat, double cLong) async {
    GeoLatLang? geoLatLang = await OpenGeocoder.getAddressWithLatLong(
        latitude: cLat, longitude: cLong);
    if (geoLatLang != null) {
      address = geoLatLang;
      lat = cLat;
      long = cLong;
      debugPrint(address!.displayName);
    }
  }

  Future<void> getGeoCodeWithAddress(GeoLatLang address) async {
    List<GeoData> addressesList =
        await OpenGeocoder.getAddressesWithName(name: address.name ?? "");
    if (addressesList.isNotEmpty) {
      lat = double.parse(addressesList[0].latitude!);
      long = double.parse(addressesList[0].longitude!);
      debugPrint('$lat,$long');
    }
  }
}
