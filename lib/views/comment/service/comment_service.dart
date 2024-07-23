import 'package:haydi_ekspres_dev_tools/haydi_ekspres_dev_tools.dart';
import 'package:haydi_express_customer/core/managers/network_manager.dart';
import 'package:dio/dio.dart';

final class CommentService extends NetworkManager {
  Future<dynamic> writeComment(CommentModel data, String accessToken) async {
    try {
      final response = await network.post(
        Endpoints.instance.writeComment,
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
