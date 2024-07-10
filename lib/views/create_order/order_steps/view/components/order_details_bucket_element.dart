part of '../order_steps_view.dart';

class OrderDetailsBucketElement extends StatelessWidget {
  final String menuName;
  final int price;
  final int count;
  const OrderDetailsBucketElement(
      {super.key,
      required this.menuName,
      required this.price,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.horizontal10,
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: RichText(
          text: TextSpan(
            style: TextConsts.instance.regularThird16Bold,
            text: menuName,
            children: <TextSpan>[
              TextSpan(
                text: " x$count",
                style: TextConsts.instance.regularBlack16,
              ),
            ],
          ),
        ),
        trailing: Text(
          "${price * count}₺",
          style: TextConsts.instance.regularThird16Bold,
        ),
      ),
    );
  }
}
