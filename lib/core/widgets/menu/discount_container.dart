import 'package:flutter/material.dart';

import '../../consts/color_consts/color_consts.dart';
import '../../consts/padding_consts.dart';
import '../../consts/radius_consts.dart';
import '../../consts/text_consts.dart';

class DiscountContainer extends StatelessWidget {
  final int discountAmount;
  final EdgeInsetsGeometry? margin;
  const DiscountContainer(
      {super.key, required this.discountAmount, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? PaddingConsts.instance.left30,
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: ColorConsts.instance.third,
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      child: Center(
        child: Text(
          "%$discountAmount",
          style: TextConsts.instance.regularWhite16Bold,
        ),
      ),
    );
  }
}
