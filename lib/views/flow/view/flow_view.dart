import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/app_consts.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_button.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/button/custom_text_button.dart';
import 'package:haydi_express_customer/core/widgets/menu/minimized_menu.dart';
import 'package:haydi_express_customer/core/widgets/skeleton_widget.dart';
import 'package:haydi_express_customer/views/address/create_edit_address/view/create_edit_address_view.dart';
import 'package:haydi_express_customer/views/category_list/view/category_list_view.dart';
import 'package:haydi_express_customer/views/search/view/search_view.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../core/init/model/menu_model.dart';
import '../viewmodel/flow_viewmodel.dart';

part './components/categorized_flow_list.dart';
part './components/create_address_bottom_sheet.dart';

class FlowView extends StatelessWidget {
  const FlowView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<FlowViewModel>(
        viewModel: FlowViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: PaddingConsts.instance.top20,
                    child: Padding(
                      padding: PaddingConsts.instance.horizontal10,
                      child: const SearchBarView(),
                    ),
                  ),
                  _buildTitle(
                    context,
                    model,
                    category: AppConst.instance.haydiFirsatlar,
                    text: "Haydi Fırsatlar",
                    alignment: Alignment.topLeft,
                    color: ColorConsts.instance.lightSecondary,
                  ),
                  _buildList(
                    context,
                    model,
                    future: model.fetchHaydiFirsatlar(),
                  ),
                  _buildTitle(
                    context,
                    model,
                    category: AppConst.instance.discover,
                    text: "Ne Yesem?",
                    alignment: Alignment.topRight,
                    color: ColorConsts.instance.secondary,
                  ),
                  _buildList(
                    context,
                    model,
                    future: model.fetchDiscover(),
                  ),
                  _buildTitle(
                    context,
                    model,
                    category: "Favorilerim",
                    text: "Favorilerim",
                    alignment: Alignment.topLeft,
                    color: ColorConsts.instance.primary,
                  ),
                  _buildList(
                    context,
                    model,
                    future: model.fetchUserFavoriteFoods(),
                  ),
                ],
              ),
            ),
          );
        },
        onModelReady: (model) {
          model.setContext(context);
          model.initViewModelInstance(model);
          model.init();
        },
        onDispose: (model) {});
  }

  Widget _buildTitle(BuildContext context, FlowViewModel model,
      {required String text,
      required Alignment alignment,
      required String category,
      required Color color}) {
    return Align(
      alignment: alignment,
      child: Container(
        //Margin is here
        margin: PaddingConsts.instance.top20,
        width: MediaQuery.of(context).size.width - 80,
        padding: PaddingConsts.instance.horizontal10,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: ColorConsts.instance.shadow,
          color: color,
          borderRadius: alignment == Alignment.topLeft
              ? RadiusConsts.instance.circularRight100
              : RadiusConsts.instance.circularLeft100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextConsts.instance.regularBlack20Bold,
            ),
            category == "Favorilerim"
                ? const SizedBox()
                : CustomTextButton(
                    onPressed: () => model.navigateToSeeAll(
                        category,
                        CategoryListView(
                          category: category,
                          appBarColor: color,
                        )),
                    style: TextConsts.instance.regularBlack14Underlined,
                    text: "Tümünü Gör",
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, FlowViewModel model,
      {required Future<List<MenuModel>> future}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: FutureBuilder<List<MenuModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return CategorizedFlowList(
              dataList: snapshot.data!,
              viewModel: model,
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Bu kategoriye uygun bir menü bulunmamakta.",
                style: TextConsts.instance.regularBlack18Bold,
              ),
            );
          } else {
            return SkeletonWidget(
                widget: MinimizedMenu(
              viewModel: model,
              data: AppConst.instance.mockMenuModel,
            ));
          }
        },
      ),
    );
  }
}
