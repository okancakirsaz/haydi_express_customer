import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/base/viewmodel/base_viewmodel.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';
import 'package:haydi_express_customer/core/widgets/menu/menu_rating_stars.dart';

class MinimizedMenu extends StatelessWidget {
  final MenuModel data;
  final BaseViewModel viewModel;
  final int? calculatedDiscountedPrice;
  const MinimizedMenu(
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
        width: 250,
        height: 140,
        decoration: BoxDecoration(
          color: ColorConsts.instance.background,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildImage(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTitle(),
                    Padding(
                      padding: PaddingConsts.instance.left10,
                      child: Padding(
                        padding: PaddingConsts.instance.top10,
                        child: _information(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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

  Widget _buildImage() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: 90,
          height: 80,
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
        MenuRatingStars(starCount: data.stats.likeRatio ~/ 20),
      ],
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      width: 130,
      child: Text(
        textAlign: TextAlign.center,
        data.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextConsts.instance.regularBlack16Bold,
      ),
    );
  }

  Widget _information() {
    return Row(
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
