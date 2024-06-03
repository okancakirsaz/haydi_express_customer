import 'package:flutter/material.dart';
import 'package:haydi_express_customer/core/init/cache/local_manager.dart';
import 'package:haydi_express_customer/core/managers/navigation_manager.dart';
import 'package:intl/intl.dart';

import '../../init/cache/local_keys_enums.dart';
import '../../widgets/error_dialog.dart';
import '../../widgets/success_dialog.dart';

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

  showSuccessDialog([String? reason]) {
    SuccessDialog(
        context: viewModelContext, reason: reason ?? "İşlem Başarılı!");
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

  int calculateDiscount(int price, int discountAmount) {
    return (price - ((price * discountAmount) / 100)).toInt();
  }

  Future<void> bringDataFromCacheOrApi(String dataKey,
      {required Function getFromApi, required Function getFromCache}) async {
    try {
      final List<dynamic>? cachedData =
          localeManager.getNullableJsonData(dataKey);
      if (cachedData == null) {
        await getFromApi();
        debugPrint("$dataKey getting from api...");
      } else {
        await getFromCache();
        debugPrint("$dataKey getting from local storage...");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  String? get accessToken =>
      localeManager.getNullableStringData(LocaleKeysEnums.accessToken.name);
}
