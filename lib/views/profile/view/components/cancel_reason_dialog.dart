part of '../profile_view.dart';

class CancelReasonDialog extends StatelessWidget {
  final ProfileViewModel viewModel;
  final OrderModel data;
  const CancelReasonDialog(
      {super.key, required this.viewModel, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConsts.instance.background,
        title: CustomTextField(
          hintStyle: TextConsts.instance.regularBlack16,
          controller: viewModel.cancelReason,
          hint: "Sipariş iptal nedeni giriniz.",
        ),
        content: CustomStateFullButton(
          onPressed: () async => await viewModel.cancelOrder(data),
          text: "Onayla",
        ));
  }
}
