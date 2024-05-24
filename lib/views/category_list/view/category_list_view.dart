import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/skeleton_widget.dart';
import 'package:haydi_express_customer/core/widgets/vertical_list_minimized_menu.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../viewmodel/category_list_viewmodel.dart';

class CategoryListView extends StatelessWidget {
  final String category;
  final Color appBarColor;
  const CategoryListView(
      {super.key, required this.category, required this.appBarColor});

  @override
  Widget build(BuildContext context) {
    return BaseView<CategoryListViewModel>(
      viewModel: CategoryListViewModel(),
      onPageBuilder: (context, model) {
        return CustomScaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Text(
                    category,
                    style: TextConsts.instance.regularBlack25Bold,
                  ),
                  snap: true,
                  floating: true,
                  backgroundColor: appBarColor,
                )
              ];
            },
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: SafeArea(
                child: FutureBuilder<List<MenuModel>>(
                  future: model.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Container(
                          color: ColorConsts.instance.background,
                          child: _buildList(model),
                        ),
                      );
                    } else {
                      return _buildSkeleton(model);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
      onModelReady: (model) {
        model.category = category;
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }

  Widget _buildList(CategoryListViewModel model) {
    return Observer(builder: (context) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: model.dataList.length + 1,
        itemBuilder: (context, index) {
          if (index == model.dataList.length && model.dataList.isNotEmpty) {
            return CustomTextButton(
              onPressed: () async => model.fetchMoreData(),
              text: "Daha fazla",
              style: TextConsts.instance.regularBlack18Underlined,
            );
          } else if (model.dataList.isNotEmpty) {
            return VerticalListMinimizedMenu(
              data: model.dataList[index],
              calculatedDiscountedPrice: model.dataList[index].isOnDiscount
                  ? model.calculateDiscount(model.dataList[index].price,
                      model.dataList[index].discountAmount!)
                  : null,
            );
          } else {
            return const SizedBox();
          }
        },
      );
    });
  }

  Widget _buildSkeleton(CategoryListViewModel model) {
    return SkeletonWidget(
      scrollDirection: Axis.vertical,
      widget: VerticalListMinimizedMenu(data: AppConst.instance.mockMenuModel),
    );
  }
}
