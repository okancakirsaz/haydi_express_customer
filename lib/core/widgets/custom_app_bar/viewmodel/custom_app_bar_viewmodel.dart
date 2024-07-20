import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/chat/view/chat_view.dart';
import 'package:haydi_express_customer/views/main_view/viewmodel/main_viewmodel.dart';
import '../../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'custom_app_bar_viewmodel.g.dart';

class CustomAppBarViewModel = _CustomAppBarViewModelBase
    with _$CustomAppBarViewModel;

abstract class _CustomAppBarViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  @observable
  int pageIndex = 0;

  late final MainViewModel mainViewModel;

  void setMainViewModel(MainViewModel model) => mainViewModel = model;

  @action
  changePage(Widget page, int index) {
    mainViewModel.changePage(page);
    pageIndex = index;
  }

  navigateToLiveSupport() {
    navigationManager.navigate(
      const ChatView(targetId: "live-support", targetName: "Canlı Destek"),
    );
  }
}
