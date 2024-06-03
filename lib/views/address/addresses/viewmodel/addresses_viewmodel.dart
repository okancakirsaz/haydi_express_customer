import 'package:flutter/material.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'addresses_viewmodel.g.dart';

class AddressesViewModel = _AddressesViewModelBase with _$AddressesViewModel;

abstract class _AddressesViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() {}
}
