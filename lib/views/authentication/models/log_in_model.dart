import 'package:haydi_express_customer/views/authentication/models/customer_model.dart';

class LogInModel {
  String mail;
  String password;
  bool isLoginSuccess;
  String? unSuccessfulReason;
  CustomerModel? customerData;
  String? uid;
  String? accessToken;

  LogInModel({
    required this.mail,
    required this.password,
    required this.isLoginSuccess,
    this.unSuccessfulReason,
    this.customerData,
    this.uid,
    this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'mail': mail,
      'password': password,
      'isLoginSuccess': isLoginSuccess,
      'unSuccessfulReason': unSuccessfulReason,
      'uid': uid,
      'customerData': customerData?.toJson(),
      'accessToken': accessToken,
    };
  }

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      mail: json['mail'] as String,
      password: json['password'] as String,
      isLoginSuccess: json['isLoginSuccess'] as bool,
      unSuccessfulReason: json['unSuccessfulReason'] as String?,
      uid: json['uid'] as String?,
      customerData: json['customerData'] != null
          ? CustomerModel.fromJson(json['customerData'])
          : null,
      accessToken: json['accessToken'] as String?,
    );
  }

  @override
  String toString() =>
      "LogInModel(mail: $mail,password: $password,isLoginSuccess: $isLoginSuccess,unSuccessfulReason: $unSuccessfulReason)";

  @override
  int get hashCode =>
      Object.hash(mail, password, isLoginSuccess, unSuccessfulReason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogInModel &&
          runtimeType == other.runtimeType &&
          mail == other.mail &&
          password == other.password &&
          isLoginSuccess == other.isLoginSuccess &&
          unSuccessfulReason == other.unSuccessfulReason;
}
