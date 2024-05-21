import 'package:flutter/material.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'category_list_viewmodel.g.dart';

class CategoryListViewModel = _CategoryListViewModelBase
    with _$CategoryListViewModel;

abstract class _CategoryListViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}
}
