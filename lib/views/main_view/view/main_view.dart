import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/widgets/custom_app_bar/view/custom_app_bar_view.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/main_viewmodel.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MainViewModel>(
      viewModel: MainViewModel(),
      onPageBuilder: (context, model) {
        return Observer(builder: (context) {
          return CustomScaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  CustomAppBar(
                    mainViewModel: model,
                  ),
                  Expanded(child: model.currentPage),
                ],
              ),
            ),
          );
        });
      },
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }
}
