part of '../flow_view.dart';

class CustomSearchBar extends StatelessWidget {
  final FlowViewModel viewModel;
  const CustomSearchBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
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
              hintText: viewModel.searchBarHint,
              textStyle:
                  MaterialStatePropertyAll(TextConsts.instance.regularBlack16),
              hintStyle: MaterialStatePropertyAll(
                  TextConsts.instance.regularLightGrey18),
              backgroundColor:
                  MaterialStatePropertyAll(ColorConsts.instance.darkBlurGrey),
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
          //TODO: Remove mock values and continue
          return List<Widget>.generate(6, (int index) {
            final List<SuggestionModel> items = [
              AppConst.instance.menuSuggestionBoosted,
              AppConst.instance.menuSuggestionBoostedDiscounted,
              AppConst.instance.restaurantSuggestionBoosted,
              AppConst.instance.menuSuggestion,
              AppConst.instance.menuSuggestionDiscounted,
              AppConst.instance.restaurantSuggestion,
            ];
            return Suggestion(data: items[index], viewModel: viewModel);
          });
        });
  }
}
