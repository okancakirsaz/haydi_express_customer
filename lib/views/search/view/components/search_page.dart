part of '../search_view.dart';

class SearchPage extends StatelessWidget {
  final SearchViewModel viewModel;
  final List<SuggestionModel> suggestions;
  final String keyword;
  const SearchPage(
      {super.key,
      required this.viewModel,
      required this.suggestions,
      required this.keyword});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConsts.instance.background,
          title: RichText(
            text: TextSpan(
                text: keyword,
                style: TextConsts.instance.regularBlack18Bold,
                children: [
                  TextSpan(
                      text: " için bulunan sonuçlar.",
                      style: TextConsts.instance.regularBlack16)
                ]),
          ),
        ),
        body: suggestions.isEmpty ? _buildEmptyState() : _buildList());
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: PaddingConsts.instance.all5,
          child: Suggestion(data: suggestions[index], viewModel: viewModel),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
        child: Text(
      "Aramanıza uygun sonuç bulunamadı.",
      style: TextConsts.instance.regularThird16Bold,
    ));
  }
}
