import 'package:flutter/material.dart';

class RadiusConsts {
  static final RadiusConsts instance = RadiusConsts();

  //All
  final BorderRadiusGeometry circularAll5 =
      const BorderRadius.all(Radius.circular(5));
  final BorderRadiusGeometry circularAll10 =
      const BorderRadius.all(Radius.circular(10));
  final BorderRadiusGeometry circularAll20 =
      const BorderRadius.all(Radius.circular(20));
  final BorderRadiusGeometry circularAll40 =
      const BorderRadius.all(Radius.circular(40));
  final BorderRadiusGeometry circularAll100 =
      const BorderRadius.all(Radius.circular(100));
  //Left
  final BorderRadiusGeometry circularLeft10 = const BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
  final BorderRadiusGeometry circularLeft100 = const BorderRadius.only(
      topLeft: Radius.circular(100), bottomLeft: Radius.circular(100));
  //Right
  final BorderRadiusGeometry circularRight10 = const BorderRadius.only(
      topRight: Radius.circular(10), bottomRight: Radius.circular(10));
  final BorderRadiusGeometry circularRight20 = const BorderRadius.only(
      topRight: Radius.circular(20), bottomRight: Radius.circular(20));
  final BorderRadiusGeometry circularRight100 = const BorderRadius.only(
      topRight: Radius.circular(100), bottomRight: Radius.circular(100));
  //Top
  final BorderRadiusGeometry circularTop10 = const BorderRadius.only(
      topRight: Radius.circular(10), topLeft: Radius.circular(10));
  final BorderRadiusGeometry circularTop100 = const BorderRadius.only(
      topRight: Radius.circular(100), topLeft: Radius.circular(100));
  final BorderRadiusGeometry circularTop50 = const BorderRadius.only(
      topRight: Radius.circular(50), topLeft: Radius.circular(50));
  //Bottom
  final BorderRadiusGeometry circularBottom10 = const BorderRadius.only(
      bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10));
  final BorderRadiusGeometry circularBottom100 = const BorderRadius.only(
      bottomRight: Radius.circular(100), bottomLeft: Radius.circular(100));
  final BorderRadiusGeometry circularBottom20 = const BorderRadius.only(
      bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20));
}
