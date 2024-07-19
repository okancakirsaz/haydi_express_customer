part of '../profile_view.dart';

class OrderHistory extends StatelessWidget {
  final ProfileViewModel viewModel;
  const OrderHistory({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: PartTitle(
            title: "Profilim",
            subtitle: "Geçmiş Siparişler",
          ),
        ),
        _buildOrders(),
      ],
    );
  }

  Widget _buildOrders() {
    return FutureBuilder<bool>(
      future: viewModel.getOrderLogs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (viewModel.orderHistory.isEmpty) {
            return Padding(
              padding: PaddingConsts.instance.top20,
              child: Text(
                "Geçmiş siparişiniz yok.",
                style: TextConsts.instance.regularBlack18Bold,
              ),
            );
          } else {
            return Observer(builder: (context) {
              return Column(
                children: viewModel.orderHistory
                    .map(
                      (e) => Padding(
                        padding: PaddingConsts.instance.top10,
                        child: OrderWidget(
                          viewModel: viewModel,
                          data: viewModel.orderHistory[
                              viewModel.getOrderHistoryIndex(e.orderId)],
                          isOrderExpired: true,
                          index: viewModel.getOrderHistoryIndex(e.orderId),
                        ),
                      ),
                    )
                    .toList(),
              );
            });
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConsts.instance.third,
            ),
          );
        }
      },
    );
  }
}
