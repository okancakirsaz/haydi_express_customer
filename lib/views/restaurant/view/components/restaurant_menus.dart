part of '../restaurant_view.dart';

class RestaurantMenus extends StatelessWidget {
  final RestaurantViewModel viewModel;
  const RestaurantMenus({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        viewModel.restaurantData.wantDeliveryFromUs
            ? Padding(
                padding: PaddingConsts.instance.all20,
                child:
                    const ServiceInformation(restaurantNames: "Bu işletme, "),
              )
            : const SizedBox(),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemCount: viewModel.menus.length,
          itemBuilder: (context, index) {
            MenuModel data = viewModel.menus[index];
            return VerticalListMinimizedMenu(
              data: data,
              viewModel: viewModel,
              calculatedDiscountedPrice: data.isOnDiscount
                  ? viewModel.calculateDiscount(
                      data.price, data.discountAmount!)
                  : null,
            );
          },
        ),
      ],
    );
  }
}
