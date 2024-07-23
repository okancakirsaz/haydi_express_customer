import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/models/bucket_element_model.dart';
import 'package:haydi_ekspres_dev_tools/models/comment_model.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_statefull_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';
import 'package:haydi_express_customer/core/widgets/menu/menu_rating_stars.dart';
import 'package:haydi_express_customer/core/widgets/menu/minimized_menu.dart';
import '../../../../core/base/view/base_view.dart';
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
                    data: data,
                    viewModel: model,
                  ),
                ],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.initOpenedMenu(data);
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
