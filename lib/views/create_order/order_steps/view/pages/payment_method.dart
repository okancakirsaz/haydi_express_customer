part of '../order_steps_view.dart';

class PaymentMethod extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const PaymentMethod({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: OrderStepsAppBar().build(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomStepper(
              steps: viewModel.steps,
              currentStep: 2,
              height: 150,
            ),
            Text(
              "Lütfen bir ödeme yöntemi seçiniz",
              style: TextConsts.instance.regularBlack20,
            ),
            _buildButton(PaymentMethods.creditCard, false),
            _buildButton(PaymentMethods.cash, false),
            _buildButton(PaymentMethods.online, true),
            //TODO: Will be open this method
            //_buildButton(PaymentMethods.foodTicket, false),
          ],
        ));
  }

  Widget _buildButton(PaymentMethods method, bool isOnlinePayment) {
    return Padding(
      padding: PaddingConsts.instance.all10,
      child: CustomButton(
        style: TextConsts.instance.regularWhite18,
        width: double.infinity,
        gradient: isOnlinePayment
            ? ColorConsts.instance.thirdGradient
            : ColorConsts.instance.primaryGradient,
        onPressed: () => viewModel.choosePaymentMethod(method, viewModel),
        text: method.value,
      ),
    );
  }
}
