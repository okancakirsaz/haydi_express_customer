import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:toastification/toastification.dart';

import '../consts/color_consts/color_consts.dart';

class SuccessDialog {
  final String reason;
  final BuildContext context;
  SuccessDialog({required this.context, required this.reason}) {
    show();
  }
  show() {
    toastification.show(
      primaryColor: ColorConsts.instance.primary,
      context: context,
      type: ToastificationType.success,
      title: Text(
        reason,
        style: TextConsts.instance.regularBlack16,
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
