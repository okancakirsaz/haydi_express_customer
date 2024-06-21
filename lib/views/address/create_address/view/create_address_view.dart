import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_dropdown.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_field.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/create_address_viewmodel.dart';
import 'components/map_component.dart';

part './components/create_address_inputs.dart';

class CreateAddressView extends StatelessWidget {
  final AddressModel? data;
  const CreateAddressView({super.key, this.data});

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
                      child: CustomButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (context) => _nameDialog(model)),
                        text: "Onayla",
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
          model.fetchIsEditMode(data);
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

  Widget _nameDialog(CreateAddressViewModel model) {
    return AlertDialog(
        backgroundColor: ColorConsts.instance.background,
        title: CustomTextField(
          hintStyle: TextConsts.instance.regularBlack16,
          controller: model.addressName,
          hint: "Adrese bir isim veriniz",
        ),
        content: CustomStateFullButton(
          onPressed: () async => await model.sendCreateOrEditRequest(),
          text: "Onayla",
        ));
  }
}
