import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/menu/service/menu_service.dart';
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

  Future<List<MenuModel>> getSimilarFoods(List tags) async {
    final List<MenuModel> response =
        await service.getSimilarFoods(tags, accessToken!) ?? [];
    return response;
  }
}
