import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';

class MinimizedMenu extends StatelessWidget {
  final MenuModel data;
  final int? calculatedDiscountedPrice;
  const MinimizedMenu(
      {super.key, required this.data, this.calculatedDiscountedPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildImage() {
    return Container(
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
            ? _discountAmount()
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

  Widget _discountAmount() {
    return Container(
      margin: PaddingConsts.instance.left30,
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: ColorConsts.instance.third,
        borderRadius: RadiusConsts.instance.circularAll10,
      ),
      child: Center(
        child: Text(
          "%${data.discountAmount}",
          style: TextConsts.instance.regularWhite16Bold,
        ),
      ),
    );
  }
}
