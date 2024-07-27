import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_ekspres_dev_tools/widgets/widgets_index.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/create_edit_address_viewmodel.dart';
import 'components/map_component.dart';

part 'components/create_address_inputs.dart';

class CreateEditAddressView extends StatelessWidget {
  final AddressModel? data;
  const CreateEditAddressView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateEditAddressViewModel>(
        viewModel: CreateEditAddressViewModel(),
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

  Widget _nameDialog(CreateEditAddressViewModel model) {
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
