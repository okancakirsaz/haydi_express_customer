import 'package:haydi_express_customer/core/consts/endpoints.dart';
import 'package:haydi_express_customer/core/init/model/menu_model.dart';

import '../../../../core/managers/network_manager.dart';

final class PublicService extends NetworkManager {
  Future<List<MenuModel>?> getAdvertedMenu(String category) async {
    try {
      final response = await network.get(
        Endpoints.instance.getAdvertedMenus,
        queryParameters: {"category": category},
      );
      final List<MenuModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(MenuModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }
}
