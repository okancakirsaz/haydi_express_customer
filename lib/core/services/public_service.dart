import 'package:dio/dio.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';

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

  Future<List<MenuModel>?> getMoreAdvertedMenu(
      String category, String lastItemDate, String accessToken) async {
    try {
      final response = await network.get(
          Endpoints.instance.getMoreAdvertedMenus,
          queryParameters: {"category": category, "expire": lastItemDate},
          options: Options(headers: setHeaderAccessToken(accessToken)));

      final List<MenuModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(MenuModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }

  Future<List<MenuModel>?> getDiscoverMenu(String accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.discover,
          options: Options(headers: setHeaderAccessToken(accessToken)));

      final List<MenuModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(MenuModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }

  Future<List<MenuModel>?> getMoreDiscoverMenu(
      int likeRatio, String accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.getMoreDiscover,
          queryParameters: {"likeRatio": likeRatio},
          options: Options(headers: setHeaderAccessToken(accessToken)));

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
