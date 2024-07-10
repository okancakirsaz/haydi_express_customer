import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

import '../../../../core/consts/endpoints.dart';

final class OrderStepsService extends NetworkManager {
  Future<List?> isRestaurantsUsesHe(
      List<String> data, String accessToken) async {
    try {
      final response = await network.post(Endpoints.instance.isRestaurantUsesHe,
          data: jsonEncode(data),
          options: Options(
            headers: setHeaderAccessToken(accessToken),
          ));

      return response.data;
    } catch (e) {
      return null;
    }
  }
}
