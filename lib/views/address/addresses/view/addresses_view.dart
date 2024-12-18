import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_scaffold.dart';
import 'package:haydi_ekspres_dev_tools/widgets/custom_text_button.dart';
import 'package:haydi_express_customer/views/address/create_edit_address/view/create_edit_address_view.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/addresses_viewmodel.dart';

part 'components/address_component.dart';
part 'components/addresses_empty_component.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressesViewModel>(
        viewModel: AddressesViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: PaddingConsts.instance.all20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Adreslerim",
                        style: TextConsts.instance.regularBlack20Bold,
                      ),
                      CustomTextButton(
                        onPressed: () => model.navigationManager.navigate(
                          const CreateEditAddressView(),
                        ),
                        style: TextConsts.instance.regularBlack16Underlined,
                        text: "Adres Ekle",
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<int>(
                    future: model.getAddresses(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && model.addresses.isEmpty ||
                          snapshot.data == -1) {
                        return _buildEmptyState();
                      } else if (snapshot.hasData && snapshot.data == 1) {
                        return _buildAddressesList(model);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
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
    return Observer(builder: (context) {
      return ListView.builder(
          itemCount: model.addresses.length,
          itemBuilder: (context, index) {
            return AddressComponent(
              viewModel: model,
              address: model.addresses[index],
            );
          });
    });
  }

  Widget _buildEmptyState() {
    return const AddressesEmptyComponent();
  }
}
