import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}

  @observable
  Widget currentPage = const FlowView();

  @action
  changePage(Widget newPage) {
    currentPage = newPage;
  }
}
