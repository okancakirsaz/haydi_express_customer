part of '../restaurant_view.dart';

class RestaurantComments extends StatelessWidget {
  final RestaurantViewModel viewModel;
  const RestaurantComments({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.comments.isEmpty) {
      return Padding(
        padding: PaddingConsts.instance.top30,
        child: Padding(
          padding: PaddingConsts.instance.horizontal10,
          child: Text(
            "Bu restoran hakkında henüz bir yorum yok.",
            style: TextConsts.instance.regularBlack18Bold,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.comments.length,
          itemBuilder: (context, index) {
            return _comment(viewModel.comments[index]);
          },
        ),
      );
    }
  }

  Widget _comment(CommentModel comment) {
    return Container(
      width: 270,
      height: 170,
      padding: PaddingConsts.instance.all5,
      margin: PaddingConsts.instance.all10,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularAll10,
        boxShadow: ColorConsts.instance.shadow,
        gradient: ColorConsts.instance.thirdGradient,
      ),
      child: Padding(
        padding: PaddingConsts.instance.horizontal10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              comment.comment,
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
              style: TextConsts.instance.regularWhite16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MenuRatingStars(
                  starSize: 18,
                  starCount: comment.like,
                ),
                Text(
                  comment.like.toStringAsFixed(1),
                  style: TextConsts.instance.regularPrimary18Bold,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
