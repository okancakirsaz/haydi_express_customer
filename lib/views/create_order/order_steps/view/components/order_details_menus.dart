part of '../order_steps_view.dart';

class OrderDetailsMenus extends StatelessWidget {
  final OrderStepsViewModel viewModel;
  const OrderDetailsMenus({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: PaddingConsts.instance.horizontal10,
      constraints: const BoxConstraints(minHeight: 50),
      margin: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
        color: ColorConsts.instance.background,
        boxShadow: ColorConsts.instance.shadow,
        borderRadius: RadiusConsts.instance.circularAll20,
      ),
      child: Padding(
        padding: PaddingConsts.instance.all5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: viewModel.fetchBucketToDetails,
            ),
            SvgPicture.asset(
              AssetConsts.instance.addition,
              height: 10,
            ),
            Padding(
              padding: PaddingConsts.instance.right10,
              child: Padding(
                padding: PaddingConsts.instance.top5,
                child: Text("${viewModel.totalPrice}₺",
                    style: TextConsts.instance.regularBlack16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
