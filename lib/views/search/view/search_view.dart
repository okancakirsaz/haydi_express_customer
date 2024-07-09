import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haydi_express_customer/core/widgets/menu/discount_container.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../core/consts/asset_consts.dart';
import '../../../core/consts/color_consts/color_consts.dart';
import '../../../core/consts/padding_consts.dart';
import '../../../core/consts/radius_consts.dart';
import '../../../core/consts/text_consts.dart';
import '../../../core/init/model/suggestion_model.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../viewmodel/search_viewmodel.dart';

part './components/suggestion.dart';
part './components/search_page.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchViewModel>(
        viewModel: SearchViewModel(),
        onPageBuilder: (context, model) {
          return SearchAnchor(
              viewOnSubmitted: (keyword) async => model.search(keyword, model),
              isFullScreen: false,
              viewBackgroundColor: ColorConsts.instance.darkBlurGrey,
              builder: (context, controller) {
                return Observer(builder: (context) {
                  return SearchBar(
                    leading: Icon(
                      Icons.search,
                      color: ColorConsts.instance.background,
                      size: 40,
                    ),
                    onTap: () {
                      controller.openView();
                    },
                    onSubmitted: (keyword) async =>
                        model.search(keyword, model),
                    hintText: model.searchBarHint,
                    textStyle: MaterialStatePropertyAll(
                        TextConsts.instance.regularBlack16),
                    hintStyle: MaterialStatePropertyAll(
                        TextConsts.instance.regularLightGrey18),
                    backgroundColor: MaterialStatePropertyAll(
                        ColorConsts.instance.darkBlurGrey),
                    elevation: const MaterialStatePropertyAll(0),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: RadiusConsts.instance.circularAll10,
                      ),
                    ),
                    controller: controller,
                  );
                });
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<Widget>.generate(model.suggestions.length,
                    (int index) {
                  return Suggestion(
                      data: model.suggestions[index], viewModel: model);
                });
              });
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }
}
