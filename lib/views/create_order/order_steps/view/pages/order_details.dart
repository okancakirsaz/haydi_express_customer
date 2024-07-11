part of "../order_steps_view.dart";

class OrderDetails extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const OrderDetails({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: OrderStepsAppBar().build(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomStepper(
                steps: viewModel.steps,
                currentStep: 3,
                height: 150,
              ),
              Center(
                child: Text(
                  "Sipariş Detayları",
                  style: TextConsts.instance.regularBlack20,
                ),
              ),
              OrderDetailsMenus(viewModel: viewModel),
              Padding(
                padding: PaddingConsts.instance.all10,
                child: _buildServiceInformation(),
              ),
              _buildDetailsElement(
                "Ödeme Yöntemi",
                viewModel.chosenMethod!.value,
              ),
              _buildDetailsElement(
                "Sipariş Adresi",
                viewModel.fetchAddressToUi(viewModel.chosenAddress!),
              ),
              _buildDetailsElement(
                "Müşteri Telefon Numarası",
                viewModel.localeManager
                    .getStringData(LocaleKeysEnums.phoneNumber.name),
              ),
              CustomTextField(
                height: 100,
                controller: viewModel.note,
                maxLine: 5,
                hintStyle: TextConsts.instance.regularBlack16Bold,
                hint: "Sipariş Notu Girebilirsiniz",
              ),
              Center(
                child: Padding(
                  padding: PaddingConsts.instance.all10,
                  child: CustomStateFullButton(
                    width: 200,
                    style: TextConsts.instance.regularWhite20,
                    onPressed: () {},
                    text: "Haydi Gelsin!",
                    gradient: ColorConsts.instance.primaryGradient,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildDetailsElement(String key, String value) {
    return Container(
      margin: PaddingConsts.instance.all10,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: TextConsts.instance.regularThird16Bold,
          text: "$key: ",
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextConsts.instance.regularBlack16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceInformation() {
    return FutureBuilder<bool>(
      future: viewModel.checkIsAnyRestaurantUsesHe(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return ServiceInformation(
              viewModel: viewModel,
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
