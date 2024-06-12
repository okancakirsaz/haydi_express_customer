import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import '../../../../core/base/view/base_view.dart';
import '../../core/models/address_model.dart';
import '../viewmodel/addresses_viewmodel.dart';

part 'components/address_component.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressesViewModel>(
        viewModel: AddressesViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: FutureBuilder<int>(
              future: model.getAddresses(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == 1) {
                  return _buildAddressesList(model);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget _buildAddressesList(AddressesViewModel model) {
    return ListView.builder(
        itemCount: model.addresses.length,
        itemBuilder: (context, index) {
          return AddressComponent(
            viewModel: model,
            address: model.addresses[index],
          );
        });
  }

  Widget _buildEmptyState() {
    return const SizedBox();
  }
}
