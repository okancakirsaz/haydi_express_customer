part of '../create_address_view.dart';

class CreateAddressInputs extends StatelessWidget {
  final CreateAddressViewModel viewModel;
  CreateAddressInputs({super.key, required this.viewModel});
  final TextStyle inputHintStyle = TextConsts.instance.regularBlack20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConsts.instance.horizontal30,
      child: Column(
        children: <Widget>[
          _buildProvinceInputs(),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: _buildDetailsInputs(),
          )
        ],
      ),
    );
  }

  Widget _buildProvinceInputs() {
    return Row(
      children: <Widget>[
        CustomDropdown(
          props: [],
          hint: "Şehir",
          controller: viewModel.city,
          style: TextConsts.instance.regularBlack16Bold,
        ),
        const SizedBox(width: 10),
        CustomDropdown(
          props: [],
          hint: "İlçe",
          controller: viewModel.state,
          style: TextConsts.instance.regularBlack16Bold,
        ),
      ],
    );
  }

  Widget _buildDetailsInputs() {
    return Column(
      children: <Widget>[
        CustomTextField(
          hintStyle: inputHintStyle,
          controller: viewModel.neighborhood,
          hint: "Mahalle",
        ),
        CustomTextField(
          hintStyle: inputHintStyle,
          controller: viewModel.street,
          hint: "Sokak",
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomTextField(
                hintStyle: TextConsts.instance.regularBlack16,
                controller: viewModel.outDoorNumber,
                hint: "Bina Numarası",
              ),
            ),
            Expanded(
              child: CustomTextField(
                hintStyle: TextConsts.instance.regularBlack16,
                controller: viewModel.doorNumber,
                hint: "Daire Numarası",
              ),
            ),
          ],
        ),
        CustomTextField(
          hintStyle: inputHintStyle,
          controller: viewModel.addressDirection,
          hint: "Adres Tarifi",
        ),
      ],
    );
  }
}
