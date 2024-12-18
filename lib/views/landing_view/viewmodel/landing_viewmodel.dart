import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_keys_enums.dart';
import 'package:haydi_express_customer/core/managers/web_socket_manager.dart';
import 'package:haydi_express_customer/views/landing_view/view/components/lost_connection_screen.dart';
import 'package:haydi_express_customer/views/landing_view/view/components/splash_screen.dart';
import 'package:haydi_express_customer/views/landing_view/view/landing_view.dart';
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
    await clearCache();
    _checkLoggedInState();
    return defaultWidget;
  }

  final Connectivity connectivity = Connectivity();
  Widget defaultWidget = const SplashScreen();

  Future<void> clearCache() async {
    await localeManager.removeData(LocaleKeysEnums.haydiFirsatlar.name);
    await localeManager.removeData(LocaleKeysEnums.activeConversations.name);
    await localeManager.removeData(LocaleKeysEnums.discover.name);
    await localeManager.removeData(LocaleKeysEnums.advertSuggestions.name);
    await localeManager.removeData(LocaleKeysEnums.addresses.name);
    await localeManager.removeData(LocaleKeysEnums.bucket.name);
    await localeManager.removeData(LocaleKeysEnums.orderLogs.name);
  }

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

  listenConnectionState(LandingViewModel viewModel) {
    connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          navigationManager.navigateAndRemoveUntil(
            LostConnectionScreen(viewModel: viewModel),
          );
        }
      },
    );
  }

  Future<void> checkConnectivity() async {
    final List<ConnectivityResult> result =
        await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      showErrorDialog("İnternet bağlantısı bulunamamkta");
    } else {
      navigationManager.navigateAndRemoveUntil(const LandingView());
    }
  }
}
