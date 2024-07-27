import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/widgets/logo.dart';

class LogoBar extends StatelessWidget {
  final String title;
  final Alignment? alignment;
  const LogoBar({super.key, required this.title, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topLeft,
      child: Container(
        padding: PaddingConsts.instance.all5,
        width: MediaQuery.of(context).size.width - 50,
        height: 60,
        decoration: BoxDecoration(
          color: ColorConsts.instance.background,
          borderRadius: RadiusConsts.instance.circularRight100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Logo(),
            Expanded(
              child: Padding(
                padding: PaddingConsts.instance.left30,
                child: Text(
                  title,
                  style: TextConsts.instance.regularBlack23Bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
