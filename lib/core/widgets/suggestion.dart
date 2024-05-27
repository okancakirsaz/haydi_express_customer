import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_express_customer/core/base/viewmodel/base_viewmodel.dart';
import 'package:haydi_express_customer/core/consts/asset_consts.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';

import '../init/model/suggestion_model.dart';

class Suggestion extends StatelessWidget {
  final SuggestionModel data;
  final BaseViewModel viewModel;
  const Suggestion({super.key, required this.data, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data.isBoosted
          ? ColorConsts.instance.lightThird
          : ColorConsts.instance.background,
      child: SizedBox(
        height: 65,
        child: ListTile(
          minVerticalPadding: 0,
          leading: data.isBoosted
              ? SvgPicture.asset(
                  AssetConsts.instance.boostIcon,
                  width: 25,
                )
              : null,
          title: Text(
            data.name,
            style: TextConsts.instance.regularBoldCustomColor18(
                data.isBoosted ? Colors.white : Colors.black),
          ),
          subtitle: data.isRestaurant
              ? Text(
                  "Restoran",
                  style: TextConsts.instance.regularCustomColor14(
                    data.isBoosted ? Colors.white : Colors.black,
                  ),
                )
              : null,
          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Widget? _buildTrailing() {
    if (!data.isRestaurant && data.isOnDiscount) {
      return SizedBox(
        width: 100,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${data.price}₺",
                  style: TextConsts.instance.regularPrimary16LineThrough,
                ),
                Text(
                  "${viewModel.calculateDiscount(data.price, data.discountAmount)}₺",
                  style: TextConsts.instance.regularCustomColor16(
                    data.isBoosted ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
            Container(
              width: 50,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorConsts.instance.third,
                  borderRadius: RadiusConsts.instance.circularAll10),
              child: Text(
                "%${data.discountAmount}",
                style: TextConsts.instance.regularWhite14Bold,
              ),
            ),
          ],
        ),
      );
    } else if (!data.isRestaurant && !data.isOnDiscount) {
      return Text(
        "${data.price}₺",
        style: TextConsts.instance.regularBoldCustomColor18(
          data.isBoosted ? Colors.white : Colors.black,
        ),
      );
    } else {
      return null;
    }
  }
}
