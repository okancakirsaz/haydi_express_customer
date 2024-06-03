import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:haydi_express_customer/views/address/create_address/service/create_address_service.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart';
import 'package:yandex_maps_mapkit_lite/mapkit_factory.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'create_address_viewmodel.g.dart';

class CreateAddressViewModel = _CreateAddressViewModelBase
    with _$CreateAddressViewModel;

abstract class _CreateAddressViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    showNotificationDialog();
    mapkit.onStart();
  }

  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController outDoorNumber = TextEditingController();
  final TextEditingController doorNumber = TextEditingController();
  final TextEditingController addressDirection = TextEditingController();

  final CreateAddressService service = CreateAddressService();
  MapWindow? mapWindow;

  showNotificationDialog() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showSuccessDialog("Doğru Adres = Sıcak Yemek");
    });
  }
}
