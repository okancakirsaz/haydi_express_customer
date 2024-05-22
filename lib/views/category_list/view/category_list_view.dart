import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/skeleton_widget.dart';
import 'package:haydi_express_customer/core/widgets/vertical_list_minimized_menu.dart';
import '../../../../core/base/view/base_view.dart';
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
                      return _buildList(model, snapshot.data!);
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

  Widget _buildList(CategoryListViewModel model, List<MenuModel> data) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: data.length + 1,
      itemBuilder: (context, index) {
        if (index == data.length) {
          //TODO: Contuniue here
          return Center(
            child: CircularProgressIndicator(
              color: ColorConsts.instance.primary,
            ),
          );
        } else {
          return VerticalListMinimizedMenu(
            data: data[index],
            calculatedDiscountedPrice: data[index].isOnDiscount
                ? model.calculateDiscount(
                    data[index].price, data[index].discountAmount!)
                : null,
          );
        }
      },
    );
  }

  Widget _buildSkeleton(CategoryListViewModel model) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: (context, index) {
        return SkeletonWidget(
            widget: VerticalListMinimizedMenu(
                data: AppConst.instance.mockMenuModel));
      },
    );
  }
}
