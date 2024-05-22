import 'package:haydi_express_customer/core/init/model/comment_model.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';
import 'package:haydi_express_customer/core/init/model/menu_stats_model.dart';

class AppConst {
  static final AppConst instance = AppConst();

  MenuModel mockMenuModel = MenuModel(
    name: "Example Name",
    price: 100,
    photoUrl: "https://via.placeholder.com/600/92c952",
    content: "Example content here",
    tags: ["Example Tag 1", "Example Tag 2"],
    restaurantUid: "Example Restaurant Uid",
    isOnDiscount: false,
    discountAmount: null,
    discountFinishDate: null,
    menuId: "menuId",
    stats: MenuStatsModel(
      creationDate: "creationDate",
      totalOrderCount: 1,
      likeRatio: 50,
      mostOrderTakingHour: "20.00",
      totalRevenue: 2000,
      comments: [
        CommentModel(comment: "comment", like: 5),
      ],
    ),
    restaurantName: "restaurantName",
  );

  //Flow categories
  final String haydiFirsatlar = "Haydi Fırsatlar";
}
