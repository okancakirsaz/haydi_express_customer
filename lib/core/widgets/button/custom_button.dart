import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle? style;
  final String text;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final BorderRadiusGeometry radius = RadiusConsts.instance.circularAll10;
  CustomButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.text,
    this.width,
    this.height,
    this.backgroundColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 160,
      height: height ?? 50,
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: 130,
      ),
      decoration: BoxDecoration(
        boxShadow: ColorConsts.instance.shadow,
        color: backgroundColor ?? ColorConsts.instance.primary,
        borderRadius: radius,
        gradient: gradient,
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: radius),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: style ?? TextConsts.instance.regularWhite25,
          )),
    );
  }
}
