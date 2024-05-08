import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_manager.dart';
import 'package:haydi_express_customer/core/managers/navigation_manager.dart';
import 'package:intl/intl.dart';

import '../../widgets/error_dialog.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  NavigationManager get navigationManager =>
      NavigationManager(viewModelContext);
  void init() {}
  final ScrollController defaultScrollController = ScrollController();

  showErrorDialog([String? reason]) {
    ErrorDialog(
      context: viewModelContext,
      reason: reason ?? "Bir sorun oluştu, daha sonra tekrar deneyiniz.",
    );
  }

  navigatorPop() {
    if (Navigator.canPop(viewModelContext)) {
      Navigator.pop(viewModelContext);
    }
  }

  String parseIso8601DateFormat(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);

    return DateFormat('dd.MM.yyyy').format(dateTime);
  }
}
