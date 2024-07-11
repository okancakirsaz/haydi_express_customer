import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:haydi_express_customer/views/create_order/core/models/order_model.dart';

import '../../../../core/consts/endpoints.dart';
import '../../../../core/init/model/http_exception_model.dart';

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

  Future<dynamic> createOrder(OrderModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.createOrder,
        data: data.toJson(),
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      if (response.data != "true") {
        return HttpExceptionModel.fromJson(response.data);
      } else {
        return bool.parse(response.data);
      }
    } catch (e) {
      return null;
    }
  }
}
