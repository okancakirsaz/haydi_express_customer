import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_ekspres_dev_tools/widgets/menu_rating_stars.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';

import '../../base/viewmodel/base_viewmodel.dart';

class VerticalListMinimizedMenu extends StatelessWidget {
  final MenuModel data;
  final int? calculatedDiscountedPrice;
  final BaseViewModel viewModel;
  const VerticalListMinimizedMenu(
      {super.key,
      required this.data,
      this.calculatedDiscountedPrice,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => viewModel.navigateToMenu(data,
          calcDiscountPrice: calculatedDiscountedPrice),
      child: Container(
        margin: PaddingConsts.instance.all10,
        padding: PaddingConsts.instance.all5,
        decoration: BoxDecoration(
          color: ColorConsts.instance.background,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildImage(context),
            _buildTitle(context),
            _information(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                data.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextConsts.instance.regularBlack14,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: BoxDecoration(
            color: ColorConsts.instance.background,
            borderRadius: RadiusConsts.instance.circularAll10,
            image: DecorationImage(
              image: NetworkImage(
                data.photoUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        _buildLikeRatio(context),
      ],
    );
  }

  Widget _buildLikeRatio(BuildContext context) {
    if (data.stats.likeRatio ~/ 20 >= 1) {
      return Container(
        width: 100,
        padding: PaddingConsts.instance.all3,
        margin: PaddingConsts.instance.all5,
        decoration: BoxDecoration(
          color: ColorConsts.instance.third,
          borderRadius: RadiusConsts.instance.circularAll5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MenuRatingStars(starCount: data.stats.likeRatio ~/ 20),
            Text(
              (data.stats.likeRatio / 20).toStringAsFixed(1),
              style: TextConsts.instance.regularWhite12,
            )
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        textAlign: TextAlign.center,
        data.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextConsts.instance.regularBlack18Bold,
      ),
    );
  }

  Widget _information() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        calculatedDiscountedPrice != null ? _discountedPrice() : _normalPrice(),
        calculatedDiscountedPrice != null
            ? DiscountContainer(discountAmount: data.discountAmount!)
            : const SizedBox(),
      ],
    );
  }

  Widget _discountedPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${data.price}₺",
          style: TextConsts.instance.regularPrimary16LineThrough,
        ),
        Text(
          "${calculatedDiscountedPrice}₺",
          style: TextConsts.instance.regularBlack16,
        ),
      ],
    );
  }

  Widget _normalPrice() {
    return Padding(
      padding: PaddingConsts.instance.top10,
      child: Text(
        "${data.price}₺",
        style: TextConsts.instance.regularBlack20,
      ),
    );
  }
}
