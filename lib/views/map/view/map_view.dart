import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/map_viewmodel.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MapViewModel>(
        viewModel: MapViewModel(),
        onPageBuilder: (context, model) {
          return YandexMap(
            onMapCreated: (mapWindow) => model.mapInit(mapWindow),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
