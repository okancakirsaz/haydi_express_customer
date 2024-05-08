import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';

class PageTopContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  const PageTopContainer({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConsts.instance.third,
        borderRadius: RadiusConsts.instance.circularBottom100,
        boxShadow: ColorConsts.instance.shadow,
      ),
      child: SafeArea(child: child),
    );
  }
}
