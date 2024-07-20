import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class CustomStateFullButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle? style;
  final String text;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;
  const CustomStateFullButton(
      {super.key,
      required this.onPressed,
      this.style,
      required this.text,
      this.width,
      this.height,
      this.gradient,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: height ?? 50,
      constraints: const BoxConstraints(
        minHeight: 50,
        minWidth: 100,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: ColorConsts.instance.shadow,
        color: backgroundColor ?? ColorConsts.instance.primary,
        border: Border.all(color: Colors.transparent),
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      child: EasyButton(
          type: EasyButtonType.text,
          buttonColor: ColorConsts.instance.primary,
          borderRadius: 10,
          onPressed: onPressed,
          idleStateWidget: Text(
            text,
            style: style ?? TextConsts.instance.regularWhite25,
            textAlign: TextAlign.center,
          ),
          loadingStateWidget: Padding(
            padding: PaddingConsts.instance.all10,
            child: CircularProgressIndicator(
              color: ColorConsts.instance.lightThird,
            ),
          )),
    );
  }
}
