import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';

import '../consts/text_consts.dart';

class CustomStateFullButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle? style;
  final String text;
  final double? width;
  final double? height;
  const CustomStateFullButton(
      {super.key,
      required this.onPressed,
      this.style,
      required this.text,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: height ?? 50,
      constraints: const BoxConstraints(
        minHeight: 50,
        minWidth: 150,
      ),
      decoration: BoxDecoration(
        color: ColorConsts.instance.primary,
        border: Border.all(),
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
