import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle? style;
  final String text;
  final Color? backGroundColor;
  final double? width;
  final double? height;
  const CustomButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.text,
    this.width,
    this.height,
    this.backGroundColor,
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
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(2),
            backgroundColor: MaterialStatePropertyAll(
                backGroundColor ?? ColorConsts.instance.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: RadiusConsts.instance.circularAll10,
              ),
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
