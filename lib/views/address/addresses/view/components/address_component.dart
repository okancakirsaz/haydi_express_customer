part of '../addresses_view.dart';

class AddressComponent extends StatelessWidget {
  final AddressesViewModel viewModel;
  final AddressModel address;
  const AddressComponent(
      {super.key, required this.viewModel, required this.address});

  String get formattedAddress =>
      """${address.neighborhood}, ${address.street}, Bina No: ${address.buildingNumber}, Kat: ${address.floor}, Kapı No: ${address.doorNumber}, ${address.city}/${address.state}
Adres Tarifi: ${address.addressDirection}
""";

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: ColorConsts.instance.background,
      backgroundColor: ColorConsts.instance.blurGrey,
      childrenPadding: PaddingConsts.instance.all10,
      title: Text(
        address.name,
        style: TextConsts.instance.regularThird16Bold,
      ),
      subtitle: subtitle,
      children: <Widget>[
        _buildMap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () async => await viewModel.deleteAddress(address.uid),
              icon: Icon(
                Icons.delete,
                size: 30,
                color: ColorConsts.instance.primary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                size: 30,
                color: ColorConsts.instance.third,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget get subtitle => Text(
        maxLines: 50,
        formattedAddress,
        overflow: TextOverflow.ellipsis,
        style: TextConsts.instance.regularThird14,
      );

  Widget _buildMap() {
    return address.lat != null
        ? Container(
            width: double.infinity,
            height: 200,
            margin: PaddingConsts.instance.all10,
            decoration: BoxDecoration(
              borderRadius: RadiusConsts.instance.circularAll10,
            ),
            child: FlutterMap(
                options: MapOptions(
                  initialZoom: 17,
                  initialCenter: LatLng(address.lat!, address.long!),
                ),
                children: [
                  TileLayer(
                    urlTemplate: Endpoints.instance.mapTile,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(address.lat!, address.long!),
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
          )
        : const SizedBox();
  }
}
