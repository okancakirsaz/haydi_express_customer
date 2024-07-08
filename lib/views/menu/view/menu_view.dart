import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';
import 'package:haydi_express_customer/core/widgets/menu/menu_rating_stars.dart';
import 'package:haydi_express_customer/core/widgets/menu/minimized_menu.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../core/consts/radius_consts.dart';
import '../../../core/init/model/comment_model.dart';
import '../viewmodel/menu_viewmodel.dart';

part './components/counter.dart';
part './components/top_menu_view.dart';
part './components/comments.dart';
part './components/similar_foods.dart';

class MenuView extends StatelessWidget {
  final MenuModel data;
  final int? calculatedDiscountedPrice;
  const MenuView(
      {super.key, required this.data, this.calculatedDiscountedPrice});

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
        viewModel: MenuViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TopMenuView(
                    data: data,
                    viewModel: model,
                    calculatedDiscountedPrice: calculatedDiscountedPrice,
                  ),
                  Comments(
                    comments: data.stats.comments,
                    viewModel: model,
                  ),
                  SimilarFoods(
                    tags: data.tags,
                    viewModel: model,
                  ),
                ],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
