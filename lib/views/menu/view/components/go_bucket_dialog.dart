import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_text_button.dart';
import 'package:toastification/toastification.dart';

class GoBucketDialog {
  final String text;
  final BuildContext context;
  final VoidCallback navigate;
  GoBucketDialog(this.context, {required this.text, required this.navigate}) {
    show();
  }

  show() {
    toastification.show(
      context: context,
      title: Text(
        text,
        style: TextConsts.instance.regularBlack16,
      ),
      autoCloseDuration: const Duration(milliseconds: 300),
      type: ToastificationType.success,
      description: CustomTextButton(
        onPressed: navigate,
        style: TextConsts.instance.regularPrimary18BoldUnderlined,
        text: "Sepete Git",
      ),
    );
  }
}
