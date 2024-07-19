import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

import '../../../core/consts/endpoints.dart';
import '../../../core/init/model/http_exception_model.dart';
import '../../create_order/core/models/order_model.dart';
import '../model/cancel_order_model.dart';

final class ProfileService extends NetworkManager {
  Future<dynamic> deleteAccount(String customerId, String accessToken) async {
    try {
      final response = await network.delete(
        Endpoints.instance.deleteAccount,
        queryParameters: {"customerId": customerId},
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

  Future<dynamic> changePersonalValue(String customerId, String newValue,
      String type, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.change,
        queryParameters: {
          "customerId": customerId,
          "newValue": newValue,
          "changedValue": type
        },
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

  Future<dynamic> cancelOrder(CancelOrderModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.cancelOrder,
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

  Future<List<OrderModel>?> getActiveOrders(
      String customerId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getActiveOrders,
        queryParameters: {"customerId": customerId},
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      return (response.data as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  Future<List<OrderModel>?> getOrderLogs(
      String restaurantId, String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getOrderLogs,
        queryParameters: {
          "restaurantId": restaurantId,
        },
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );
      List asList = (response.data as List);
      if (asList.isEmpty) {
        return [];
      } else {
        return asList.map((e) => OrderModel.fromJson(e)).toList();
      }
    } catch (e) {
      return null;
    }
  }
}
