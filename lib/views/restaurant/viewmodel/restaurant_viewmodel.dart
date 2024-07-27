import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_ekspres_dev_tools/models/work_hours_model.dart';
import 'package:haydi_express_customer/views/restaurant/service/restaurant_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_viewmodel.g.dart';

class RestaurantViewModel = _RestaurantViewModelBase with _$RestaurantViewModel;

abstract class _RestaurantViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {
    _checkIsRestaurantWorkingNow();
  }

  initRestaurantData(RestaurantModel data) => restaurantData = data;

  late final RestaurantModel restaurantData;
  bool isRestaurantWorking = false;
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

  _checkIsRestaurantWorkingNow() {
    final WorkHoursModel hours = restaurantData.workHours;
    final int hour = DateTime.now().hour;
    final int minute = DateTime.now().minute;
    final double currentTime = double.parse("$hour.$minute");
    final double startHour =
        double.parse("${hours.startHour}.${hours.startMinute}");
    final double endHour = double.parse("${hours.endHour}.${hours.endMinute}");
    if (startHour <= currentTime && endHour > currentTime) {
      isRestaurantWorking = true;
      return;
    }
  }
}
