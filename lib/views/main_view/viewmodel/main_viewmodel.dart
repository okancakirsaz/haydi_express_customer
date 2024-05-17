import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/widgets/custom_scaffold.dart';
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
  Widget currentPage = const CustomScaffold(
    body: Center(child: Text("1")),
  );

  @action
  changePage(Widget newPage) {
    currentPage = newPage;
  }
}
