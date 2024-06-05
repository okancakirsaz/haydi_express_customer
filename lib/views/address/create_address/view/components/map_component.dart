import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:yandex_maps_mapkit_lite/yandex_map.dart';

import '../../../../../core/consts/color_consts/color_consts.dart';
import '../../../../../core/consts/radius_consts.dart';
import '../../viewmodel/create_address_viewmodel.dart';

class MapComponent extends StatelessWidget {
  final CreateAddressViewModel viewModel;
  const MapComponent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    try {
      return Observer(builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: viewModel.mapHeight,
          decoration: BoxDecoration(
            boxShadow: ColorConsts.instance.shadow,
            borderRadius: RadiusConsts.instance.circularAll10,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: YandexMap(
              onMapCreated: (mapWindow) => viewModel.mapInit(mapWindow),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => viewModel.changeMapExtend(),
              child: const Icon(
                Icons.fullscreen,
                size: 40,
              ),
            ),
          ),
        );
      });
    } catch (e) {
      debugPrint("$e");
      return Container(
        width: MediaQuery.of(context).size.width,
        height: viewModel.mapHeight,
        decoration: BoxDecoration(
          color: ColorConsts.instance.background,
          boxShadow: ColorConsts.instance.shadow,
          borderRadius: RadiusConsts.instance.circularAll10,
        ),
        child: Text(
          "Harita getirilirken bir sorun oluştu.",
          style: TextConsts.instance.regularThird16Bold,
        ),
      );
    }
  }
}
