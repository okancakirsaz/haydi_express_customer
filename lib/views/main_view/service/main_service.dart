import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

import '../../../core/consts/endpoints.dart';

final class MainService extends NetworkManager {
  Future<String?> getMapKitApiKey(accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.mapKit,
          options: Options(headers: setHeaderAccessToken(accessToken)));

      return response.data;
    } catch (e) {
      return null;
    }
  }
}
