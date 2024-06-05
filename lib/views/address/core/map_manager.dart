import 'package:yandex_maps_mapkit_lite/mapkit.dart';

final class MapCameraListenerImpl implements MapCameraListener {
  //Default value is initial value
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

final class MapObjectTapListenerImpl implements MapObjectTapListener {
  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    return true;
  }
}

final class MapInputListenerImpl implements MapInputListener {
  @override
  void onMapLongTap(Map map, Point point) {}

  @override
  void onMapTap(Map map, Point point) {}
}
