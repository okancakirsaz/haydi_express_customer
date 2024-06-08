import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_express_customer/core/consts/asset_consts.dart';

class MenuRatingStars extends StatelessWidget {
  final int starCount;
  const MenuRatingStars({super.key, required this.starCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
        starCount,
        growable: false,
        (index) => SvgPicture.asset(
          width: 15,
          AssetConsts.instance.star,
        ),
      ),
    );
  }
}
