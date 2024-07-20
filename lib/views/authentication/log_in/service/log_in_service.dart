import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/models_index.dart';

import '../../../../core/managers/network_manager.dart';

final class LogInService extends NetworkManager {
  Future<LogInCustomerModel?> logIn(LogInCustomerModel data) async {
    try {
      final response = await network.post(Endpoints.instance.logInCustomer,
          data: data.toJson());
      return LogInCustomerModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
