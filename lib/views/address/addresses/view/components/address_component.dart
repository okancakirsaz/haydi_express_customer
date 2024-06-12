part of '../addresses_view.dart';

class AddressComponent extends StatelessWidget {
  final AddressesViewModel viewModel;
  final AddressModel address;
  const AddressComponent(
      {super.key, required this.viewModel, required this.address});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        address.name,
        style: TextConsts.instance.regularThird16Bold,
      ),
      //TODO: Contuniue here
    );
  }
}
