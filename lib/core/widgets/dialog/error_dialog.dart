import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:toastification/toastification.dart';

class ErrorDialog {
  final String reason;
  final BuildContext context;
  ErrorDialog({required this.context, required this.reason}) {
    show();
  }
  show() {
    toastification.show(
      primaryColor: ColorConsts.instance.primary,
      context: context,
      title: Text(
        reason,
        style: TextConsts.instance.regularBlack16,
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
