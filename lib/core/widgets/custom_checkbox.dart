import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Widget titleWidget;
  final Color? checkColor;
  final Function(bool? data) onChanged;
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.titleWidget,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: value,
          checkColor: checkColor ?? ColorConsts.instance.third,
          onChanged: onChanged,
          activeColor: ColorConsts.instance.primary,
        ),
        Padding(
          padding: PaddingConsts.instance.left5,
          child: titleWidget,
        ),
      ],
    );
  }
}
