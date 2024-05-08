import 'package:haydi_express_customer/core/consts/endpoints.dart';
import 'package:haydi_express_customer/views/authentication/models/log_in_model.dart';

import '../../../../core/managers/network_manager.dart';

final class LogInService extends NetworkManager {
  Future<LogInModel?> logIn(LogInModel data) async {
    try {
      final response =
          await network.post(Endpoints.instance.logIn, data: data.toJson());
      return LogInModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
