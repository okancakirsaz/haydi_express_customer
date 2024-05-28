import 'package:dio/dio.dart';
import 'package:haydi_express_customer/core/init/model/suggestion_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

import '../../../core/consts/endpoints.dart';

final class FlowService extends NetworkManager {
  Future<List<SuggestionModel>?> getSearchAds(String accessToken) async {
    try {
      final response = await network.get(
        Endpoints.instance.getSearchAds,
        options: Options(
          headers: setHeaderAccessToken(accessToken),
        ),
      );

      List<SuggestionModel> dataList = [];

      for (Map<String, dynamic> data in response.data) {
        dataList.add(SuggestionModel.fromJson(data));
      }

      return dataList;
    } catch (e) {
      return null;
    }
  }
}
