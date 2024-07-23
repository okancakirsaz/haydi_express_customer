part of '../menu_view.dart';

class TopMenuView extends StatelessWidget {
  final MenuViewModel viewModel;
  final MenuModel data;
  final int? calculatedDiscountedPrice;
  const TopMenuView(
      {super.key,
      required this.viewModel,
      required this.data,
      this.calculatedDiscountedPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildImage(viewModel),
        Padding(
          padding: PaddingConsts.instance.horizontal10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: PaddingConsts.instance.top10,
                child: _basicInformation(),
              ),
              Padding(
                padding: PaddingConsts.instance.top5,
                child: _ratingAndCounter(viewModel),
              )
            ],
          ),
        ),
        CustomStateFullButton(
          onPressed: () async => await viewModel.addToBucket(
              BucketElementModel(menuElement: data, count: viewModel.counter)),
          width: 200,
          gradient: ColorConsts.instance.primaryGradient,
          text: "Sepete Ekle",
        ),
      ],
    );
  }

  Widget _buildImage(MenuViewModel model) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                data.photoUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: PaddingConsts.instance.top40,
          child: IconButton(
            onPressed: () => model.navigatorPop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ],
    );
  }

  Widget _basicInformation() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            style: TextConsts.instance.regularBlack23Bold,
          ),
          InkWell(
            onTap: () async => await viewModel.navigateToRestaurant(),
            child: Padding(
              padding: PaddingConsts.instance.top5,
              child: Text(
                data.restaurantName,
                textAlign: TextAlign.left,
                style: TextConsts.instance.regularBlack16,
              ),
            ),
          ),
          _price(),
          Padding(
            padding: PaddingConsts.instance.bottom10,
            child: Padding(
              padding: PaddingConsts.instance.top5,
              child: Text(
                data.content,
                textAlign: TextAlign.left,
                style: TextConsts.instance.regularBlack16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _price() {
    return data.isOnDiscount
        ? _discountedPrice()
        : Text(
            "${data.price}₺",
            textAlign: TextAlign.left,
            style: TextConsts.instance.regularPrimary20Bold,
          );
  }

  Widget _ratingAndCounter(MenuViewModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            MenuRatingStars(
              starCount: data.stats.likeRatio ~/ 20,
              starSize: 20,
            ),
            data.stats.likeRatio > 1
                ? Text(
                    (data.stats.likeRatio / 20).toStringAsFixed(1),
                    style: TextConsts.instance.regularPrimary20Bold,
                  )
                : const SizedBox(),
          ],
        ),
        Padding(
          padding: PaddingConsts.instance.top30,
          child: Counter(viewModel: model),
        ),
      ],
    );
  }

  Widget _discountedPrice() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${data.price}₺",
              style: TextConsts.instance.regularPrimary18LineThrough,
            ),
            Text(
              "${calculatedDiscountedPrice}₺",
              style: TextConsts.instance.regularBlack18,
            ),
          ],
        ),
        DiscountContainer(
          discountAmount: data.discountAmount!,
          margin: PaddingConsts.instance.left10,
        ),
      ],
    );
  }
}
