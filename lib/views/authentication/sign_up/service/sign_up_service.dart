import 'package:haydi_ekspres_dev_tools/constants/endpoints.dart';
import 'package:haydi_ekspres_dev_tools/models/customer_model.dart';
import 'package:haydi_ekspres_dev_tools/models/http_exception_model.dart';
import 'package:haydi_ekspres_dev_tools/models/mail_verification_model.dart';
import 'package:haydi_ekspres_dev_tools/models/mail_verification_request_model.dart';
import '../../../../core/managers/network_manager.dart';

final class SignUpService extends NetworkManager {
  Future<MailVerificationRequestModel?> sendVerifyRequest(
      MailVerificationRequestModel data) async {
    try {
      final response = await network.post(
          Endpoints.instance.mailVerificationRequest,
          data: data.toJson());
      return MailVerificationRequestModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<MailVerificationModel?> verifyMailCode(
      MailVerificationModel data) async {
    try {
      final response = await network.post(Endpoints.instance.mailVerification,
          data: data.toJson());
      return MailVerificationModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> signUp(CustomerModel data) async {
    try {
      final response = await network.post(Endpoints.instance.signUpCustomer,
          data: data.toJson());
      if (response.data.containsKey("status")) {
        return HttpExceptionModel.fromJson(response.data);
      } else {
        return CustomerModel.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
  }
}
