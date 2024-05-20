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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildTitle(),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[],
          ),
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
    //TODO: Handle overflow problem
    return Text(
      data.name,
      overflow: TextOverflow.fade,
      style: TextConsts.instance.regularBlack18Bold,
    );
  }
}
