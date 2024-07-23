import 'package:haydi_ekspres_dev_tools/models/comment_model.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_stats_model.dart';
import 'package:haydi_ekspres_dev_tools/models/suggestion_model.dart';

class AppConst {
  static final AppConst instance = AppConst();

  //Mock Models
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
        CommentModel(
          comment: "comment",
          uid: "id",
          like: 5,
          restaurantId: "Example Restaurant Uid",
          menuId: "menuId",
          customerId: "customer-id",
        ),
      ],
    ),
    restaurantName: "restaurantName",
  );

  final SuggestionModel restaurantSuggestionBoosted = SuggestionModel(
    name: "Mock Restaurant",
    isRestaurant: true,
    isOnDiscount: false,
    isBoosted: true,
    price: 0,
    discountAmount: 0,
    elementId: "mock-element-id",
  );

  final SuggestionModel restaurantSuggestion = SuggestionModel(
    name: "Mock Restaurant 2",
    isRestaurant: true,
    isOnDiscount: false,
    isBoosted: false,
    price: 0,
    discountAmount: 0,
    elementId: "mock-element-id6",
  );

  final SuggestionModel menuSuggestionBoostedDiscounted = SuggestionModel(
    name: "Mock Menu 1",
    isRestaurant: false,
    isOnDiscount: true,
    isBoosted: true,
    price: 100,
    discountAmount: 20,
    elementId: "mock-element-id2",
  );

  final SuggestionModel menuSuggestionBoosted = SuggestionModel(
    name: "Mock Menu 2",
    isRestaurant: false,
    isOnDiscount: false,
    isBoosted: true,
    price: 100,
    discountAmount: 0,
    elementId: "mock-element-id3",
  );

  final SuggestionModel menuSuggestionDiscounted = SuggestionModel(
    name: "Mock Menu 3",
    isRestaurant: false,
    isOnDiscount: true,
    isBoosted: false,
    price: 100,
    discountAmount: 20,
    elementId: "mock-element-id4",
  );

  final SuggestionModel menuSuggestion = SuggestionModel(
    name: "Mock Menu 4",
    isRestaurant: false,
    isOnDiscount: false,
    isBoosted: false,
    price: 100,
    discountAmount: 0,
    elementId: "mock-element-id5",
  );

  //Flow categories
  final String haydiFirsatlar = "Haydi Fırsatlar";
  final String discover = "Ne Yesem?";
}
