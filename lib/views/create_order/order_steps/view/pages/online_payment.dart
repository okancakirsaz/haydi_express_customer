part of '../order_steps_view.dart';

class OnlinePayment extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const OnlinePayment({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: OrderStepsAppBar().build(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomStepper(
                steps: viewModel.steps,
                currentStep: 2,
                height: 150,
              ),
              buildCreditCard(),
              buildInputs()
            ],
          ),
        ));
  }

  Widget buildCreditCard() {
    return Observer(builder: (context) {
      return CreditCardWidget(
        cardNumber: viewModel.cardNumber,
        obscureCardNumber: false,
        obscureCardCvv: false,
        isHolderNameVisible: true,
        obscureInitialCardNumber: false,
        expiryDate: viewModel.expireDate,
        cardBgColor: ColorConsts.instance.lightThird,
        cardHolderName: viewModel.cardHolderName,
        cvvCode: viewModel.cvvCode,
        showBackView: viewModel.isCvvFocused,
        onCreditCardWidgetChange: (CreditCardBrand brand) {},
      );
    });
  }

  Widget buildInputs() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConsts.instance.background,
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      padding: PaddingConsts.instance.all10,
      child: Column(
        children: <Widget>[
          CreditCardForm(
            disableCardNumberAutoFillHints: true,
            cvvValidationMessage: "Geçerli bir kod giriniz.",
            dateValidationMessage: "Geçerli bir tarih giriniz.",
            numberValidationMessage: "Geçerli bir kart numarası giriniz.",
            inputConfiguration: InputConfiguration(
              cardNumberDecoration:
                  buildInputDecorationForCardForm("Kart Numarası"),
              cardHolderDecoration:
                  buildInputDecorationForCardForm("Kart Sahibi"),
              expiryDateDecoration: buildInputDecorationForCardForm("SKT"),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cardNumber: viewModel.cardNumber,
            expiryDate: viewModel.expireDate,
            cardHolderName: viewModel.cardHolderName,
            cvvCode: viewModel.cvvCode,
            onCreditCardModelChange: (CreditCardModel cardModel) =>
                viewModel.onCreditCardModelChange(cardModel),
            formKey: viewModel.formKey,
          ),
          Padding(
            padding: PaddingConsts.instance.top10,
            child: CustomStateFullButton(
              onPressed: () async => await viewModel.goToDetailsPage(viewModel),
              gradient: ColorConsts.instance.primaryGradient,
              style: TextConsts.instance.regularWhite18,
              text: "Devam Et",
              width: 200,
              height: 40,
            ),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: CustomStateFullButton(
              onPressed: () async => await viewModel.deleteSavedCardData(),
              gradient: ColorConsts.instance.thirdGradient,
              style: TextConsts.instance.regularWhite18,
              text: "Kayıtlı Kart Bilgilerini Sil",
              width: 240,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecorationForCardForm(String label) {
    return InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConsts.instance.primary),
        ),
        label: Text(
          label,
          style: TextConsts.instance.regularBlack18,
        ));
  }
}
