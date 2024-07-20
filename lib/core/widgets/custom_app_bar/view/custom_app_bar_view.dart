import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/widgets/custom_app_bar/viewmodel/custom_app_bar_viewmodel.dart';
import 'package:haydi_express_customer/views/address/addresses/view/addresses_view.dart';
import 'package:haydi_express_customer/views/create_order/bucket/view/bucket_view.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view.dart';
import 'package:haydi_express_customer/views/main_view/viewmodel/main_viewmodel.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haydi_express_customer/views/profile/view/profile_view.dart';
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
          _buildAppBarElement(
              const AddressesView(), 1, AssetConsts.instance.mapMarker),
          _buildAppBarElement(
              const BucketView(), 2, AssetConsts.instance.orders),
          _buildAppBarElement(
              const ProfileView(), 3, AssetConsts.instance.profile),
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
      heroTag: "app-bar-btn",
      onPressed: () => model.navigateToLiveSupport(),
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
