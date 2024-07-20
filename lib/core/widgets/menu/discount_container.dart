import 'package:flutter/material.dart';

import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

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
