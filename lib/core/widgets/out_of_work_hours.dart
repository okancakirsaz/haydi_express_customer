import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/color_consts.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/constants/text_consts.dart';
import 'package:haydi_ekspres_dev_tools/models/work_hours_model.dart';

class OutOfWorkHours extends StatelessWidget {
  final WorkHoursModel hours;
  const OutOfWorkHours({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: ColorConsts.instance.blurGrey,
        ),
        child: Center(
          child: Padding(
            padding: PaddingConsts.instance.all10,
            child: Text(
              "Bu restoran şu an çalışma saatleri dışında olduğundan sipariş kabul edemez. \n Çalışma Saatleri: ${hours.startHour}:${hours.startMinute} - ${hours.endHour}:${hours.endMinute}",
              style: TextConsts.instance.regularBlack20Bold,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
