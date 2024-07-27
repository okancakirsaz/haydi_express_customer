import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_express_customer/core/widgets/menu/vertical_list_minimized_menu.dart';
import 'package:haydi_express_customer/core/widgets/out_of_work_hours.dart';
import 'package:haydi_express_customer/views/create_order/order_steps/view/order_steps_view.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/restaurant_viewmodel.dart';

part './components/restaurant_menus.dart';
part './components/restaurant_comments.dart';
part './components/top_information.dart';

class RestaurantView extends StatelessWidget {
  final RestaurantModel data;
  const RestaurantView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BaseView<RestaurantViewModel>(
      viewModel: RestaurantViewModel(),
      onPageBuilder: (context, model) {
        return CustomScaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              _buildView(model),
              model.isRestaurantWorking
                  ? const SizedBox()
                  : OutOfWorkHours(
                      hours: model.restaurantData.workHours,
                    ),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.initRestaurantData(data);
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }

  Widget _buildView(RestaurantViewModel model) {
    return FutureBuilder<bool>(
      future: model.getRestaurantContents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TopInformation(viewModel: model),
                _buildTitle(
                  "Menüler",
                  false,
                  ColorConsts.instance.lightThird,
                ),
                RestaurantMenus(
                  viewModel: model,
                ),
                _buildTitle(
                  "Yorumlar",
                  true,
                  ColorConsts.instance.third,
                ),
                RestaurantComments(
                  viewModel: model,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: ColorConsts.instance.primary,
            ),
          );
        }
      },
    );
  }

  Widget _buildTitle(String text, bool isRight, Color color) {
    return Align(
        alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: PaddingConsts.instance.top20,
          width: 200,
          padding: PaddingConsts.instance.horizontal10,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: ColorConsts.instance.shadow,
            color: color,
            borderRadius: isRight
                ? RadiusConsts.instance.circularLeft100
                : RadiusConsts.instance.circularRight100,
          ),
          child: Center(
            child: Text(
              text,
              style: TextConsts.instance.regularWhite20Bold,
            ),
          ),
        ));
  }
}
