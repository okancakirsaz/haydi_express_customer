import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:latlong2/latlong.dart';
import '../../viewmodel/create_edit_address_viewmodel.dart';

class MapComponent extends StatelessWidget {
  final CreateEditAddressViewModel viewModel;
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
            body: FlutterMap(
                mapController: viewModel.mapController,
                options: MapOptions(
                  initialCenter:
                      LatLng(viewModel.currentLat, viewModel.currentLong),
                  onTap: (pos, latLng) async => await viewModel.onMapTap(
                    latLng.latitude,
                    latLng.longitude,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: Endpoints.instance.mapTile,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point:
                            LatLng(viewModel.currentLat, viewModel.currentLong),
                        child: SvgPicture.asset(
                          width: 170,
                          height: 170,
                          AssetConsts.instance.mapMarker,
                          color: ColorConsts.instance.primary,
                        ),
                      ),
                    ],
                  )
                ]),
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
