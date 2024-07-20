import 'package:dio/dio.dart';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/address_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

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

  Future<bool?> deleteAddress(String id, String accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.deleteAddress,
          queryParameters: {"id": id},
          options: Options(headers: setHeaderAccessToken(accessToken)));

      return bool.parse(response.data);
    } catch (e) {
      return null;
    }
  }
}
