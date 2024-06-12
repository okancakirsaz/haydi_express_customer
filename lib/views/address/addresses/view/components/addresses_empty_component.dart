part of '../addresses_view.dart';

class AddressesEmptyComponent extends StatelessWidget {
  const AddressesEmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.bottom10,
          child: SvgPicture.asset(
            width: 200,
            height: 200,
            AssetConsts.instance.haydiCourier,
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.all10,
          child: Text(
            "Kuryenin sana sipariş ulaştırabilmesi için önce adres eklemelisin.",
            textAlign: TextAlign.center,
            style: TextConsts.instance.regularBlack20,
          ),
        )
      ],
    );
  }
}
