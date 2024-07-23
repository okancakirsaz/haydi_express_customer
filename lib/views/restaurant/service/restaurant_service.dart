import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/comment_model.dart';
import 'package:haydi_ekspres_dev_tools/models/menu_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:dio/dio.dart';

final class RestaurantService extends NetworkManager {
  Future<List<CommentModel>?> getComments(
      String restaurantId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getRestaurantComments,
        queryParameters: {
          "restaurantId": restaurantId,
        },
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      final List<CommentModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(CommentModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }

  Future<List<MenuModel>?> getMenus(
      String restaurantId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getRestaurantMenu,
        queryParameters: {
          "id": restaurantId,
        },
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
