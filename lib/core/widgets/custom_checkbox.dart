import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

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
