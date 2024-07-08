part of '../menu_view.dart';

class Comments extends StatelessWidget {
  final List<CommentModel> comments;
  final MenuViewModel viewModel;
  const Comments({super.key, required this.comments, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _title(),
        _buildCommentsList(),
      ],
    );
  }

  Widget _title() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: PaddingConsts.instance.top20,
          width: 200,
          padding: PaddingConsts.instance.horizontal10,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: ColorConsts.instance.shadow,
            color: ColorConsts.instance.third,
            borderRadius: RadiusConsts.instance.circularLeft100,
          ),
          child: Center(
            child: Text(
              "Yorumlar",
              style: TextConsts.instance.regularWhite20Bold,
            ),
          ),
        ));
  }

  Widget _buildCommentsList() {
    if (comments.isEmpty) {
      return Padding(
        padding: PaddingConsts.instance.top30,
        child: Padding(
          padding: PaddingConsts.instance.horizontal10,
          child: Text(
            "Bu menü hakkında henüz bir yorum yok.",
            style: TextConsts.instance.regularBlack18Bold,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return _comment(comments[index]);
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
                  starCount: comment.like.toInt(),
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
