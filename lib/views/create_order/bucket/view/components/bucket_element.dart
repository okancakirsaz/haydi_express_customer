part of '../bucket_view.dart';

class BucketElement extends StatelessWidget {
  final BucketViewModel viewModel;
  final int index;
  final MenuModel data;
  const BucketElement(
      {super.key,
      required this.index,
      required this.data,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 65,
        child: ListTile(
          minVerticalPadding: 0,
          title: Text(
            data.name,
            overflow: TextOverflow.ellipsis,
            style: TextConsts.instance.regularBlack18Bold,
          ),
          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildPrice(),
          IconButton(
            onPressed: () async => await viewModel.deleteBucketElement(index),
            icon: Icon(
              Icons.delete,
              color: ColorConsts.instance.primary,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    if (data.isOnDiscount) {
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
                    "${viewModel.calculateDiscount(data.price, data.discountAmount ?? 0)}₺",
                    style: TextConsts.instance.regularBlack16)
              ],
            ),
            DiscountContainer(
              margin: PaddingConsts.instance.left5,
              discountAmount: data.discountAmount!,
            ),
          ],
        ),
      );
    } else {
      return Text(
        "${data.price}₺",
        style: TextConsts.instance.regularBlack18Bold,
      );
    }
  }
}
