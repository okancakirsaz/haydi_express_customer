import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:haydi_express_customer/views/address/core/models/address_model.dart';

import '../../../../core/consts/endpoints.dart';

final class AddressesService extends NetworkManager {
  Future<List<AddressModel>?> getUserAddresses(
      String userId, String accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.getUserAddresses,
          queryParameters: {"userId": userId},
          options: Options(headers: setHeaderAccessToken(accessToken)));

      final List<AddressModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(AddressModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }
}
