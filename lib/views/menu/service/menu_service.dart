import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_ekspres_dev_tools/models/work_hours_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

final class MenuService extends NetworkManager {
  Future<List<MenuModel>?> getSimilarFoods(
      List tags, String menuId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getSimilarFoods,
        queryParameters: {"tags": jsonEncode(tags), "menuId": menuId},
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

  Future<WorkHoursModel?> getRestaurantWorkHours(
      String restaurantId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getRestaurantWorkHours,
        queryParameters: {
          "restaurantId": restaurantId,
        },
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );

      return WorkHoursModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<bool?> isMenuAvailable(String menuId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.isMenuAvailable,
        queryParameters: {"menuId": menuId},
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return bool.parse(response.data);
    } catch (e) {
      return null;
    }
  }
}
