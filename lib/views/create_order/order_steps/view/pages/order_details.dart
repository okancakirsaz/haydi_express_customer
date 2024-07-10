part of "../order_steps_view.dart";

class OrderDetails extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const OrderDetails({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: OrderStepsAppBar().build(),
        body: const Column(
          children: <Widget>[],
        ));
  }
}
