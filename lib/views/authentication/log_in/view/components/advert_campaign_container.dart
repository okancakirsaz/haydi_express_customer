part of '../log_in_view.dart';

class AdvertCampaignContainer extends StatelessWidget {
  final MenuModel data;
  final LogInViewModel viewModel;
  const AdvertCampaignContainer(
      {super.key, required this.data, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.bottom25,
      constraints: const BoxConstraints(maxHeight: 60, maxWidth: 220),
      decoration: BoxDecoration(
        color: ColorConsts.instance.blurGrey,
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.left10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    data.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextConsts.instance.regularBlack18Bold,
                  ),
                ),
                Text(
                  data.restaurantName,
                  style: TextConsts.instance.regularBlack14,
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              color: ColorConsts.instance.third,
              borderRadius: RadiusConsts.instance.circularRight10,
            ),
            child: data.isOnDiscount
                ? _buildCampaignedTrailing()
                : _buildUnCampaignedTrailing(),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignedTrailing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${data.price}₺",
              style: TextConsts.instance.regularWhite16LineThrough,
            ),
            Text(
              "${viewModel.calculateDiscount(data.price, data.discountAmount!)}₺",
              style: TextConsts.instance.regularPrimary16,
            ),
          ],
        ),
        Text(
          "%${data.discountAmount}",
          style: TextConsts.instance.regularWhite20Bold,
        ),
      ],
    );
  }

  Widget _buildUnCampaignedTrailing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: RadiusConsts.instance.circularAll10,
            image: DecorationImage(
                image: NetworkImage(data.photoUrl), fit: BoxFit.cover),
          ),
        ),
        Text(
          "${data.price}₺",
          style: TextConsts.instance.regularPrimary18Bold,
        ),
      ],
    );
  }
}
