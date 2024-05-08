import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/views/authentication/log_in/viewmodel/log_in_viewmodel.dart';
import '../../../../core/base/view/base_view.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LogInViewModel>(
        viewModel: LogInViewModel(),
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
