part of '../search_view.dart';

class Suggestion extends StatelessWidget {
  final SuggestionModel data;
  final SearchViewModel viewModel;
  const Suggestion({super.key, required this.data, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data.isBoosted
          ? ColorConsts.instance.lightThird
          : ColorConsts.instance.background,
      child: SizedBox(
        height: 65,
        child: ListTile(
          onTap: () async => await viewModel.onSuggestionTap(data),
          minVerticalPadding: 0,
          leading: data.isBoosted
              ? SvgPicture.asset(
                  AssetConsts.instance.boostIcon,
                  width: 25,
                )
              : null,
          title: Text(
            data.name,
            overflow: TextOverflow.ellipsis,
            style: TextConsts.instance.regularBoldCustomColor18(
              data.isBoosted ? Colors.white : Colors.black,
            ),
          ),
          subtitle: data.isRestaurant
              ? Text(
                  "Restoran",
                  style: TextConsts.instance.regularCustomColor14(
                    data.isBoosted ? Colors.white : Colors.black,
                  ),
                )
              : null,
          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Widget? _buildTrailing() {
    if (!data.isRestaurant && data.isOnDiscount) {
      return SizedBox(
        width: 100,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${data.price}₺",
                  style: TextConsts.instance.regularPrimary16LineThrough,
                ),
                Text(
                  "${viewModel.calculateDiscount(data.price, data.discountAmount)}₺",
                  style: TextConsts.instance.regularCustomColor16(
                    data.isBoosted ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
            DiscountContainer(
              margin: PaddingConsts.instance.left5,
              discountAmount: data.discountAmount,
            ),
          ],
        ),
      );
    } else if (!data.isRestaurant && !data.isOnDiscount) {
      return Text(
        "${data.price}₺",
        style: TextConsts.instance.regularBoldCustomColor18(
          data.isBoosted ? Colors.white : Colors.black,
        ),
      );
    } else {
      return null;
    }
  }
}
