import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

import '../../../core/consts/endpoints.dart';
import '../../../core/init/model/menu_model.dart';

final class MenuService extends NetworkManager {
  Future<List<MenuModel>?> getSimilarFoods(
      List tags, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getSimilarFoods,
        queryParameters: {"tags": jsonEncode(tags)},
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
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