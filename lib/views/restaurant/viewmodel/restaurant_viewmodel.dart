import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_express_customer/views/restaurant/service/restaurant_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_viewmodel.g.dart';

class RestaurantViewModel = _RestaurantViewModelBase with _$RestaurantViewModel;

abstract class _RestaurantViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  initRestaurantData(RestaurantModel data) => restaurantData = data;

  late final RestaurantModel restaurantData;
  final RestaurantService service = RestaurantService();
  List<MenuModel> menus = [];
  List<CommentModel> comments = [];
  int restaurantStarCount = 0;

  Future<bool> getRestaurantContents() async {
    await _getMenu();
    _getComments();
    _calculateRestaurantStarCount();
    return true;
  }

  Future<void> _getMenu() async {
    final List<MenuModel>? response =
        await service.getMenus(restaurantData.uid, accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    menus = response;
  }

  _getComments() async {
    comments =
        menus.map((e) => e.stats.comments).reduce((a, b) => a + b).toList();
  }

  _calculateRestaurantStarCount() {
    List<int> counts = comments.map((e) => e.like).toList();
    restaurantStarCount = counts.reduce((a, b) => a + b) ~/ counts.length;
  }
}
