import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:toastification/toastification.dart';

import '../consts/color_consts/color_consts.dart';

class ErrorDialog {
  final String? reason;
  final BuildContext context;
  ErrorDialog({required this.context, this.reason}) {
    show();
  }
  show() {
    toastification.show(
      primaryColor: ColorConsts.instance.primary,
      context: context,
      title: Text(
        reason ?? "Bir sorun oluştu, daha sonra tekrar deneyiniz.s",
        style: TextConsts.instance.regularBlack16,
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
