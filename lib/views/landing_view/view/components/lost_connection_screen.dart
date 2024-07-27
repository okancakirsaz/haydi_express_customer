import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/asset_consts.dart';
import 'package:haydi_ekspres_dev_tools/constants/padding_consts.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_scaffold.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_statefull_button.dart';
import 'package:haydi_express_customer/views/landing_view/viewmodel/landing_viewmodel.dart';

class LostConnectionScreen extends StatefulWidget {
  final LandingViewModel viewModel;
  const LostConnectionScreen({super.key, required this.viewModel});

  @override
  State<LostConnectionScreen> createState() => _LostConnectionScreenState();
}

class _LostConnectionScreenState extends State<LostConnectionScreen> {
  @override
  void initState() {
    widget.viewModel.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: PaddingConsts.instance.all10,
              child: SvgPicture.asset(AssetConsts.instance.lostConnection),
            ),
            Padding(
              padding: PaddingConsts.instance.all10,
              child: Text(
                textAlign: TextAlign.center,
                "Cihazınız internete bağlı değil.\nLütfen bağlantınızı kontrol ediniz.",
                style: TextConsts.instance.regularThird16Bold,
              ),
            ),
            Padding(
              padding: PaddingConsts.instance.all10,
              child: CustomStateFullButton(
                onPressed: () async =>
                    await widget.viewModel.checkConnectivity(),
                style: TextConsts.instance.regularWhite20,
                text: "Tekrar Dene",
              ),
            )
          ],
        ),
      ),
    );
  }
}
