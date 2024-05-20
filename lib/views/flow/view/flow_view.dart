import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/consts/padding_consts.dart';
import 'package:haydi_express_customer/core/consts/radius_consts.dart';
import 'package:haydi_express_customer/core/consts/text_consts.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
import 'package:haydi_express_customer/core/widgets/custom_text_button.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view_mixin.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../core/init/model/menu_model.dart';
import '../viewmodel/flow_viewmodel.dart';

part './components/categorized_flow_list.dart';

class FlowView extends StatefulWidget {
  const FlowView({super.key});

  @override
  State<FlowView> createState() => _FlowViewState();
}

class _FlowViewState extends State<FlowView>
    with FlowViewMixin, TickerProviderStateMixin {
  @override
  void initState() {
    skeletonAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    skeletonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FlowViewModel>(
        viewModel: FlowViewModel(),
        onPageBuilder: (context, model) {
          return CustomScaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildTitle(
                    context,
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
                    text: "Ne Yesem?",
                    alignment: Alignment.topRight,
                    color: ColorConsts.instance.secondary,
                  ),
                  _buildTitle(
                    context,
                    text: "Favorilerim",
                    alignment: Alignment.topLeft,
                    color: ColorConsts.instance.primary,
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

  Widget _buildTitle(BuildContext context,
      {required String text,
      required Alignment alignment,
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
            CustomTextButton(
              onPressed: () {},
              style: TextConsts.instance.regularBlack14Underlined,
              text: "Tümünü Gör",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, FlowViewModel model,
      {required Future<dynamic> future}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CategorizedFlowList(
              dataList: snapshot.data,
              viewModel: model,
            );
          } else {
            //TODO: Do skeleton widget
            return const Placeholder();
          }
        },
      ),
    );
  }
}
