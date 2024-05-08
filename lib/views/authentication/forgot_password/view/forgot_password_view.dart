import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
        viewModel: ForgotPasswordViewModel(),
        onPageBuilder: (context, model) {
          return const CustomScaffold(body: Placeholder());
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
