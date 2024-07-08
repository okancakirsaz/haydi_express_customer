part of '../menu_view.dart';

class SimilarFoods extends StatelessWidget {
  final MenuViewModel viewModel;
  final List tags;
  const SimilarFoods({super.key, required this.viewModel, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_title(), _buildSimilarFoods()],
    );
  }

  Widget _title() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: PaddingConsts.instance.top20,
          width: 200,
          padding: PaddingConsts.instance.horizontal10,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: ColorConsts.instance.shadow,
            color: ColorConsts.instance.lightThird,
            borderRadius: RadiusConsts.instance.circularRight100,
          ),
          child: Center(
            child: Text(
              "Benzer Ürünler",
              style: TextConsts.instance.regularWhite20Bold,
            ),
          ),
        ));
  }

  Widget _buildSimilarFoods() {
    return FutureBuilder<List<MenuModel>>(
      future: viewModel.getSimilarFoods(tags),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Padding(
              padding: PaddingConsts.instance.top20,
              child: Text(
                "Benzer menü bulunmamakta.",
                style: TextConsts.instance.regularBlack18Bold,
              ),
            );
          } else {
            return _menuList(snapshot.data!);
          }
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

  Widget _menuList(List<MenuModel> data) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return MinimizedMenu(
            viewModel: viewModel,
            data: data[index],
            calculatedDiscountedPrice: data[index].isOnDiscount
                ? viewModel.calculateDiscount(
                    data[index].price,
                    data[index].discountAmount!,
                  )
                : null,
          );
        },
      ),
    );
  }
}
