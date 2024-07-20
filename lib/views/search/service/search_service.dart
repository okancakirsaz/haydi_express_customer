import 'package:dio/dio.dart';
import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/suggestion_model.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';

final class SearchService extends NetworkManager {
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

  Future<List<SuggestionModel>?> search(
      String keyword, String accessToken) async {
    try {
      final response = await network.get(Endpoints.instance.search,
          queryParameters: {"keyword": keyword},
          options: Options(headers: setHeaderAccessToken(accessToken)));

      final List<SuggestionModel> dataList = [];
      for (Map<String, dynamic> data in response.data) {
        dataList.add(SuggestionModel.fromJson(data));
      }
      return dataList;
    } catch (e) {
      return null;
    }
  }
}
