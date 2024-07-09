import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';

class TextConsts {
  static final TextConsts instance = TextConsts();

  //White
  TextStyle get regularWhite25 {
    return GoogleFonts.montserrat(
      fontSize: 25,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite25Bold {
    return GoogleFonts.montserrat(
        fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold);
  }

  TextStyle get regularWhite22 {
    return GoogleFonts.montserrat(
      fontSize: 22,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite20 {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite20Bold {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularWhite16Bold {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularWhite16 {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite16LineThrough {
    return GoogleFonts.montserrat(
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      color: Colors.white,
      decorationColor: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite14 {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularWhite14Bold {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularWhite12 {
    return GoogleFonts.montserrat(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    );
  }

  //Black
  TextStyle get regularBlack25Bold {
    return GoogleFonts.montserrat(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack25 {
    return GoogleFonts.montserrat(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack23Bold {
    return GoogleFonts.montserrat(
      fontSize: 23,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack20 {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack20Bold {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack18 {
    return GoogleFonts.montserrat(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack18Underlined {
    return GoogleFonts.montserrat(
      fontSize: 18,
      decoration: TextDecoration.underline,
      decorationColor: Colors.black,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack18Bold {
    return GoogleFonts.montserrat(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack16Bold {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack16 {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack14Bold {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularBlack14 {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack16Underlined {
    return GoogleFonts.montserrat(
      fontSize: 16,
      decoration: TextDecoration.underline,
      decorationColor: Colors.black,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack14Underlined {
    return GoogleFonts.montserrat(
      fontSize: 14,
      decoration: TextDecoration.underline,
      decorationColor: Colors.black,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularBlack12 {
    return GoogleFonts.montserrat(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    );
  }

  //Primary
  TextStyle get regularPrimary20 {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: ColorConsts.instance.primary,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularPrimary20Bold {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: ColorConsts.instance.primary,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularPrimary18Bold {
    return GoogleFonts.montserrat(
      fontSize: 18,
      color: ColorConsts.instance.primary,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularPrimary18LineThrough {
    return GoogleFonts.montserrat(
      fontSize: 18,
      decoration: TextDecoration.lineThrough,
      color: ColorConsts.instance.primary,
      decorationColor: ColorConsts.instance.primary,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularPrimary18BoldUnderlined {
    return GoogleFonts.montserrat(
      fontSize: 18,
      decoration: TextDecoration.underline,
      color: ColorConsts.instance.primary,
      decorationColor: ColorConsts.instance.primary,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularPrimary16 {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: ColorConsts.instance.primary,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularPrimary16LineThrough {
    return GoogleFonts.montserrat(
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      color: ColorConsts.instance.primary,
      decorationColor: ColorConsts.instance.primary,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularPrimary16Underlined {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: ColorConsts.instance.primary,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal,
      decorationColor: ColorConsts.instance.primary,
    );
  }

  TextStyle get regularPrimary12 {
    return GoogleFonts.montserrat(
      fontSize: 12,
      color: ColorConsts.instance.primary,
      fontWeight: FontWeight.normal,
    );
  }

  //Third
  TextStyle get regularThird20 {
    return GoogleFonts.montserrat(
      fontSize: 20,
      color: ColorConsts.instance.third,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle get regularThird16Bold {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: ColorConsts.instance.third,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get regularThird14 {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: ColorConsts.instance.third,
      fontWeight: FontWeight.normal,
    );
  }

  //Other
  TextStyle get regularLightGrey18 {
    return GoogleFonts.montserrat(
      fontSize: 18,
      color: const Color(0xFFE8E8E8),
      fontWeight: FontWeight.normal,
    );
  }

  //Custom
  TextStyle regularBoldCustomColor18(Color color) {
    return GoogleFonts.montserrat(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle regularBoldCustomColor16(Color color) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle regularCustomColor16(Color color) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle regularCustomColor14(Color color) {
    return GoogleFonts.montserrat(
      fontSize: 14,
      color: color,
      fontWeight: FontWeight.normal,
    );
  }
}
