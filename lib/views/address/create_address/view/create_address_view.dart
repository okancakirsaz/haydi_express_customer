import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/custom_dropdown.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/create_address_viewmodel.dart';
import 'components/map_component.dart';

part './components/create_address_inputs.dart';

class CreateAddressView extends StatelessWidget {
  const CreateAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateAddressViewModel>(
        viewModel: CreateAddressViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            appBar: AppBar(
              title: Text(
                "Adres Ekle",
                style: TextConsts.instance.regularBlack23Bold,
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: ColorConsts.instance.background,
            ),
            body: Padding(
              padding: PaddingConsts.instance.top40,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreateAddressInputs(viewModel: model),
                    _buildPartTitle("Harita Görünümü",
                        "Adresinizi buradan da seçebilirsiniz."),
                    Padding(
                      padding: PaddingConsts.instance.horizontal10,
                      child: MapComponent(viewModel: model),
                    ),
                    Padding(
                      padding: PaddingConsts.instance.top20,
                      child: CustomStateFullButton(
                        onPressed: () {},
                        text: "Ekle",
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: (model) {
          model.dispose();
        });
  }

  Widget _buildPartTitle(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: TextConsts.instance.regularBlack18Bold,
      ),
      subtitle: Text(
        subtitle,
        style: TextConsts.instance.regularBlack16,
      ),
    );
  }
}
