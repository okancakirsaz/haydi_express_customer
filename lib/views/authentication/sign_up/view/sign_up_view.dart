import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/sign_up_viewmodel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        viewModel: SignUpViewModel(),
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
