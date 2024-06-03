import 'package:flutter/material.dart';
import 'package:haydi_express_customer/views/flow/view/flow_view.dart';
import 'package:haydi_express_customer/views/main_view/service/main_service.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:yandex_maps_mapkit_lite/init.dart' as yandexInit;

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;

  @override
  init() async {
    await initApiKeys();
    await replaceApiKeys();
  }

  final MainService service = MainService();
  @observable
  Widget currentPage = const FlowView();

  Map<String, String> apiKeys = {
    "mapKit": "undefined",
  };

  @action
  changePage(Widget newPage) {
    currentPage = newPage;
  }

  Future<void> initApiKeys() async {
    final String mapKit =
        await service.getMapKitApiKey(accessToken!) ?? "undefined";
    apiKeys["mapKit"] = mapKit;
    debugPrint("API Keys: $apiKeys");
  }

  Future<void> replaceApiKeys() async {
    await yandexInit.initMapkit(apiKey: "14ed6c2b-adf0-4449-959b-62ca9708f445");
  }
}
