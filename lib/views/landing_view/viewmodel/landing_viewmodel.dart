import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/managers/web_socket_manager.dart';
import 'package:haydi_express_customer/views/landing_view/view/components/splash_screen.dart';
import 'package:haydi_express_customer/views/main_view/view/main_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../authentication/log_in/view/log_in_view.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  Future<Widget?> init() async {
    WebSocketManager.instance.initializeSocketConnection();
    await localeManager.getSharedPreferencesInstance();
    //await localeManager.removeData(LocaleKeysEnums.id.name);
    await localeManager.removeData(LocaleKeysEnums.haydiFirsatlar.name);
    _checkLoggedInState();
    return defaultWidget;
  }

  Widget defaultWidget = const SplashScreen();

  _checkLoggedInState() {
    String? userId =
        localeManager.getNullableStringData(LocaleKeysEnums.id.name);
    if (userId == null) {
      //Auth Screen
      defaultWidget = const LogInView();
    } else {
      //Main Screen
      defaultWidget = const MainView();
    }
  }
}
