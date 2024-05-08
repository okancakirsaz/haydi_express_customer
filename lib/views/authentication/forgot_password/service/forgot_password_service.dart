import 'package:haydi_express_customer/core/consts/endpoints.dart';
import 'package:haydi_express_customer/views/authentication/models/forgot_password_model.dart';

import '../../../../core/managers/network_manager.dart';

final class ForgotPasswordService extends NetworkManager {
  Future<ForgotPasswordModel?> forgotPassword(ForgotPasswordModel data) async {
    try {
      final response = await network.post(Endpoints.instance.forgotPassword,
          data: data.toJson());
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
