part of '../order_steps_view.dart';

class ServiceInformation extends StatelessWidget {
  const ServiceInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.horizontal10,
          child: SvgPicture.asset(
            AssetConsts.instance.haydiCourier,
            width: 40,
            height: 40,
          ),
        ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextConsts.instance.regularBlack16,
              text: "Seçtiğiniz işletmeler ",
              children: <TextSpan>[
                TextSpan(
                  text: "Haydi Ekspres ",
                  style: TextConsts.instance.regularPrimary16Bold,
                ),
                TextSpan(
                  text: "ile paket servis yapmaktadir.",
                  style: TextConsts.instance.regularBlack16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
