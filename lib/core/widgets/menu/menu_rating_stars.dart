import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';

class MenuRatingStars extends StatelessWidget {
  final int starCount;
  final double? starSize;
  const MenuRatingStars({super.key, required this.starCount, this.starSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
        starCount,
        growable: false,
        (index) => SvgPicture.asset(
          width: starSize ?? 15,
          AssetConsts.instance.star,
        ),
      ),
    );
  }
}
