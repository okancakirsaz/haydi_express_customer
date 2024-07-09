part of '../order_steps_view.dart';

class ChooseAddress extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const ChooseAddress({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: OrderStepsAppBar().build(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomStepper(
              steps: viewModel.steps,
              currentStep: 1,
              width: double.infinity,
              height: 150,
            ),
            Text(
              "Adresleriniz",
              style: TextConsts.instance.regularBlack20,
            ),
            Expanded(child: _buildListView())
          ],
        ));
  }

  Widget _buildListView() {
    return FutureBuilder<List<AddressModel>>(
      future: viewModel.getAddresses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length + 1,
            itemBuilder: (context, index) {
              if (index == snapshot.data!.length) {
                return Padding(
                  padding: PaddingConsts.instance.horizontal30,
                  child: CustomButton(
                    onPressed: () => viewModel.navigationManager
                        .navigate(const CreateEditAddressView()),
                    text: "Yeni Adres Ekle",
                    gradient: ColorConsts.instance.thirdGradient,
                    style: TextConsts.instance.regularWhite20,
                  ),
                );
              } else {
                return Padding(
                  padding: PaddingConsts.instance.all10,
                  child: CustomButton(
                    onPressed: () {},
                    text: viewModel.fetchAddressToUi(snapshot.data![index]),
                    style: TextConsts.instance.regularWhite14,
                    gradient: ColorConsts.instance.primaryGradient,
                    width: double.infinity,
                    height: 70,
                  ),
                );
              }
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConsts.instance.primary,
            ),
          );
        }
      },
    );
  }
}
