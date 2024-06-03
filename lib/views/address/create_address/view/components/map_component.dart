import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

import '../../../../../core/consts/color_consts/color_consts.dart';
import '../../../../../core/consts/radius_consts.dart';
import '../../viewmodel/create_address_viewmodel.dart';

class MapComponent extends StatelessWidget {
  final CreateAddressViewModel viewModel;
  const MapComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        boxShadow: ColorConsts.instance.shadow,
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      child: YandexMap(
        platformViewType: PlatformViewType.TextureHybrid,
        onMapCreated: (mapWindow) {
          viewModel.mapWindow = mapWindow;
        },
      ),
    );
  }
}
