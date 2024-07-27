import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:haydi_ekspres_dev_tools/constants/constants_index.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import '../../../../core/base/view/base_view.dart';
import '../viewmodel/comment_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CommentView extends StatelessWidget {
  final OrderModel data;
  final TextStyle hintStyle = TextConsts.instance.regularWhite18;
  CommentView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BaseView<CommentViewModel>(
      viewModel: CommentViewModel(),
      onPageBuilder: (context, model) {
        return Container(
          margin: PaddingConsts.instance.all20,
          padding: PaddingConsts.instance.all20,
          decoration: BoxDecoration(
            borderRadius: RadiusConsts.instance.circularAll20,
            color: ColorConsts.instance.lightThird,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _ratingStars(model),
              Padding(
                padding: PaddingConsts.instance.top20,
                child: Material(
                  color: Colors.transparent,
                  child: CustomTextField(
                    controller: model.comment,
                    hint: "Yorumunuz",
                    hintStyle: hintStyle,
                    maxLine: 5,
                    height: 120,
                    maxLength: 100,
                  ),
                ),
              ),
              Padding(
                padding: PaddingConsts.instance.top20,
                child: Material(
                  color: Colors.transparent,
                  child: CustomDropdown(
                    width: 250,
                    props: model.buildMenuOptionProps(data),
                    hint: "Menü Seçiniz",
                    style: hintStyle,
                    controller: model.menuOption,
                  ),
                ),
              ),
              Padding(
                padding: PaddingConsts.instance.top20,
                child: CustomStateFullButton(
                  onPressed: () async => await model.sendComment(data),
                  text: "Gönder",
                  style: TextConsts.instance.regularWhite20,
                ),
              ),
            ],
          ),
        );
      },
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      onDispose: (model) {},
    );
  }

  Widget _ratingStars(CommentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.bottom10,
          child: Text(
            "Değerlendirme",
            style: hintStyle,
          ),
        ),
        Container(
          width: 250,
          height: 70,
          decoration: BoxDecoration(
            color: ColorConsts.instance.background,
            borderRadius: RadiusConsts.instance.circularAll20,
            boxShadow: ColorConsts.instance.shadow,
          ),
          child: Center(
            child: Observer(builder: (context) {
              return RatingStars(
                starSize: 32,
                onValueChanged: (value) => model.changeStarsValue(value),
                value: model.selectedStarCount,
                starColor: ColorConsts.instance.primary,
                valueLabelVisibility: false,
              );
            }),
          ),
        ),
      ],
    );
  }
}
