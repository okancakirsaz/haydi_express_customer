import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/consts/color_consts/color_consts.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/views/create_order/bucket/view/bucket_view.dart';
import 'package:haydi_express_customer/views/menu/service/menu_service.dart';
import 'package:haydi_express_customer/views/menu/view/components/go_bucket_dialog.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/model/menu_model.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  @observable
  int counter = 1;

  final MenuService service = MenuService();

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

  Future<void> addToBucket(MenuModel data) async {
    final List currentBucket =
        localeManager.getNullableJsonData(LocaleKeysEnums.bucket.name) ?? [];
    currentBucket.add(data.toJson());
    await localeManager.setJsonData(LocaleKeysEnums.bucket.name, currentBucket);
    showAfterAddBucketDialog(data.name);
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
}
