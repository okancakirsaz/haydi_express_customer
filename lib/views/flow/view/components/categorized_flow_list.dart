part of '../flow_view.dart';

class CategorizedFlowList extends StatelessWidget {
  final List<MenuModel> dataList;
  final FlowViewModel viewModel;
  const CategorizedFlowList(
      {super.key, required this.dataList, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return MinimizedMenu(
          data: dataList[index],
          calculatedDiscountedPrice: dataList[index].isOnDiscount
              ? viewModel.calculateDiscount(
                  dataList[index].price, dataList[index].discountAmount!)
              : null,
        );
      },
    );
  }
}
