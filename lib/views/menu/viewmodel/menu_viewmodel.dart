import 'package:flutter/material.dart';
import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_ekspres_dev_tools/models/work_hours_model.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/create_order/bucket/view/bucket_view.dart';
import 'package:haydi_express_customer/views/menu/service/menu_service.dart';
import 'package:haydi_express_customer/views/menu/view/components/go_bucket_dialog.dart';
import 'package:haydi_express_customer/views/restaurant/view/restaurant_view.dart';
import 'package:haydi_express_customer/views/search/viewmodel/search_viewmodel.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    await _checkIsMenuAvailable();
    await _getRestaurantWorkHours();
  }

  @observable
  int counter = 1;

  final MenuService service = MenuService();

  MenuModel? menuData;

  initOpenedMenu(MenuModel data) => menuData = data;

  @action
  changeCounterState(bool isIncrement) {
    switch (isIncrement) {
      case true:
        if (counter <= 19) {
          counter++;
        }
        break;
      case false:
        if (counter >= 2) {
          counter--;
        }
        break;
    }
  }

  Future<List<MenuModel>> getSimilarFoods(List tags, String menuId) async {
    final List<MenuModel> response =
        await service.getSimilarFoods(tags, menuId, accessToken!) ?? [];
    return response;
  }

  Future<void> addToBucket(BucketElementModel data) async {
    final List currentBucket =
        localeManager.getNullableJsonData(LocaleKeysEnums.bucket.name) ?? [];
    currentBucket.add(data.toJson());
    await localeManager.setJsonData(LocaleKeysEnums.bucket.name, currentBucket);
    showAfterAddBucketDialog(data.menuElement.name);
  }

  showAfterAddBucketDialog(String menuName) {
    GoBucketDialog(
      viewModelContext,
      text: "$menuName x$counter sepete eklendi.",
      navigate: () => navigationManager.navigate(
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorConsts.instance.background,
          ),
          body: const BucketView(),
        ),
      ),
    );
  }

  Future<void> _checkIsMenuAvailable() async {
    final bool? response =
        await service.isMenuAvailable(menuData!.menuId, accessToken!);
    if (response == null) {
      showErrorDialog();
      return;
    }
    if (!response) {
      navigatorPop();
      showErrorDialog("Bu menü artık mevcut değil.");
    }
  }

  Future<void> navigateToRestaurant() async {
    final RestaurantModel? response =
        await SearchViewModel().getRestaurantData(menuData!.restaurantUid);
    if (response == null) {
      showErrorDialog();
      return;
    }
    navigationManager.navigate(RestaurantView(data: response));
  }

  Future<void> _getRestaurantWorkHours() async {
    final WorkHoursModel? response = await service.getRestaurantWorkHours(
        menuData!.restaurantUid, accessToken!);
    if (response == null) {
      showErrorDialog();
      navigatorPop();
      return;
    }
    _checkIsRestaurantWorkingNow(response);
  }

  _checkIsRestaurantWorkingNow(WorkHoursModel hours) {
    final int hour = DateTime.now().hour;
    final int minute = DateTime.now().minute;
    final double currentTime = double.parse("$hour.$minute");
    final double startHour =
        double.parse("${hours.startHour}.${hours.startMinute}");
    final double endHour = double.parse("${hours.endHour}.${hours.endMinute}");
    if (startHour <= currentTime && endHour > currentTime) {
      return;
    }
    showErrorDialog(
        "Restoran şu anda çalışma saatleri dışında.\n Çalışma Saatleri: ${startHour.toStringAsFixed(2)} - ${endHour.toStringAsFixed(2)}");
    navigatorPop();
  }
}
