import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/asset_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/custom_app_bar/viewmodel/custom_app_bar_viewmodel.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view.dart';
import 'package:haydi_express_customer/views/main_view/viewmodel/main_viewmodel.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../consts/color_consts/color_consts.dart';
import '../core/app_bar_elements.dart';

class CustomAppBar extends StatefulWidget {
  final MainViewModel mainViewModel;

  CustomAppBar({
    super.key,
    required this.mainViewModel,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final List<String> elements = AppBarElements.instance.elements;

  final CustomAppBarViewModel model = CustomAppBarViewModel();

  @override
  void initState() {
    model.init();
    model.setContext(context);
    model.setMainViewModel(widget.mainViewModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.all5,
      height: 105,
      decoration: BoxDecoration(
          color: ColorConsts.instance.third,
          borderRadius: RadiusConsts.instance.circularAll100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildAppBarElement(const FlowView(), 0, AssetConsts.instance.home),
          _buildAppBarElement(const Center(child: Text("Addresses")), 1,
              AssetConsts.instance.mapMarker),
          _buildAppBarElement(const Center(child: Text("Orders")), 2,
              AssetConsts.instance.orders),
          _buildAppBarElement(const Center(child: Text("Profile")), 3,
              AssetConsts.instance.profile),
          _liveSupportButton(),
        ],
      ),
    );
  }

  Widget _buildAppBarElement(Widget page, int index, String iconPath) {
    return Padding(
      padding: PaddingConsts.instance.all5,
      child: TextButton(
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
        onPressed: () => model.changePage(page, index),
        child: Observer(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 25,
                height: 25,
                // ignore: deprecated_member_use
                color: index == model.pageIndex
                    ? ColorConsts.instance.primary
                    : ColorConsts.instance.background,
              ),
              Text(
                elements[index],
                style: index == model.pageIndex
                    ? TextConsts.instance.regularPrimary12
                    : TextConsts.instance.regularWhite12,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _liveSupportButton() {
    return FloatingActionButton(
      onPressed: () {
        //NOTE: Do navigating with main page viewModelContext
      },
      mini: true,
      backgroundColor: ColorConsts.instance.primary,
      child: Icon(
        Icons.chat,
        color: ColorConsts.instance.background,
        size: 25,
      ),
    );
  }
}