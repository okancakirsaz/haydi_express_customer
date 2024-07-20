import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/forgot_password_model.dart';
import '../../../../core/managers/network_manager.dart';

final class ForgotPasswordService extends NetworkManager {
  Future<ForgotPasswordModel?> forgotPassword(ForgotPasswordModel data) async {
    try {
      final response = await network
          .post(Endpoints.instance.forgotPasswordCustomer, data: data.toJson());
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
