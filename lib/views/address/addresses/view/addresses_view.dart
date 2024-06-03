import 'package:flutter/material.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/addresses_viewmodel.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressesViewModel>(
        viewModel: AddressesViewModel(),
        onPageBuilder: (context, model) {
          return const Scaffold();
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
