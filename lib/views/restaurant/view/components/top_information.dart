part of '../restaurant_view.dart';

class TopInformation extends StatelessWidget {
  final RestaurantViewModel viewModel;
  const TopInformation({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    AddressModel address = viewModel.restaurantData.address;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.all10,
          child: Text(
            viewModel.restaurantData.businessName,
            style: TextConsts.instance.regularBlack23Bold,
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.all10,
          child: Row(
            children: [
              MenuRatingStars(
                starCount: viewModel.restaurantStarCount,
                starSize: 20,
              ),
              viewModel.restaurantStarCount > 1
                  ? Text(
                      viewModel.restaurantStarCount.toStringAsFixed(1),
                      style: TextConsts.instance.regularPrimary20Bold,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.all10,
          child: Text(
            "${address.neighborhood}, ${address.street}, Bina No: ${address.buildingNumber}, Kapı No: ${address.doorNumber},${address.city}/${address.state}",
            style: TextConsts.instance.regularBlack16,
          ),
        ),
      ],
    );
  }
}
