import 'package:flutter/material.dart';

class ColorConsts {
  static final ColorConsts instance = ColorConsts();
  final Color background = const Color(0xFFF4F4F4);
  final Color black = const Color(0xFF000000);
  final Color primary = const Color(0xFFFF7A00);
  final Color secondary = const Color(0xFFFF9900);
  final Color lowOpacityOrange = const Color(0xCFFF9900);
  final Color lightSecondary = const Color(0xFFFFB000);
  final Color third = const Color(0xFF401F71);
  final Color lightThird = const Color(0xFF6230AD);
  final Color blurGrey = const Color(0xB4CCCCCC);
  final List<BoxShadow> shadow = [
    const BoxShadow(
      offset: Offset(5, 5),
      blurRadius: 5,
      color: Color(0x25000000),
    )
  ];
}
