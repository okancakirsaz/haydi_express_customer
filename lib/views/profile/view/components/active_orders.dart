part of '../profile_view.dart';

class ActiveOrders extends StatelessWidget {
  final ProfileViewModel viewModel;
  const ActiveOrders({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: PartTitle(
            title: "Profilim",
            subtitle: "Aktif Siparişler",
          ),
        ),
        _buildOrders(),
      ],
    );
  }

  Widget _buildOrders() {
    return FutureBuilder<bool>(
      future: viewModel.getActiveOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (viewModel.activeOrders.isEmpty) {
            return Padding(
              padding: PaddingConsts.instance.top20,
              child: Text(
                "Aktif Siparişiniz yok.",
                style: TextConsts.instance.regularBlack18Bold,
              ),
            );
          } else {
            return Observer(builder: (context) {
              return Column(
                children: viewModel.activeOrders
                    .map(
                      (e) => Padding(
                        padding: PaddingConsts.instance.top10,
                        child: OrderWidget(
                          viewModel: viewModel,
                          data: viewModel.activeOrders[
                              viewModel.getActiveOrderIndex(e.orderId)],
                          isOrderExpired: false,
                          index: viewModel.getActiveOrderIndex(e.orderId),
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
