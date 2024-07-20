import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';

final class OrderStepsAppBar {
  build() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Sipariş Oluşturma",
        style: TextConsts.instance.regularBlack23Bold,
      ),
    );
  }
}
