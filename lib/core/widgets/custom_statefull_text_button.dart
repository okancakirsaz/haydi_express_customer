import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class CustomStateFullTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle? style;
  final String text;
  final double? width;
  final double? height;
  const CustomStateFullTextButton(
      {super.key,
      required this.onPressed,
      this.style,
      required this.text,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    return EasyButton(
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
        ));
  }
}
