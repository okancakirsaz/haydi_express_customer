import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';

import '../../../../core/consts/endpoints.dart';

final class CreateAddressService extends NetworkManager {
  Future<bool> createAddress(AddressModel data, String accessToken) async {
    try {
      final response = await network.post(Endpoints.instance.createAddress,
          data: data.toJson(),
          options: Options(headers: setHeaderAccessToken(accessToken)));
      return bool.parse(response.data);
    } catch (e) {
      return false;
    }
  }
}
