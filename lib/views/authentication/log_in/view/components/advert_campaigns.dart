part of '../log_in_view.dart';

class AdvertCampaign extends StatelessWidget {
  final LogInViewModel viewModel;

  const AdvertCampaign({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
        color: ColorConsts.instance.lightThird,
        boxShadow: ColorConsts.instance.shadow,
        borderRadius: RadiusConsts.instance.circularTop50,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Haydi Fırsatlar",
            style: TextConsts.instance.regularWhite20Bold,
          ),
          //TODO: Do campaigns logic and view
        ],
      ),
    );
  }
}
