class MailVerificationRequestModel {
  String email;
  bool isMailSent;
  String? verificationCode;

  MailVerificationRequestModel({
    required this.email,
    required this.isMailSent,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isMailSent': isMailSent,
      'verificationCode': verificationCode,
    };
  }

  factory MailVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    return MailVerificationRequestModel(
      email: json['email'] as String,
      isMailSent: json['isMailSent'] as bool,
      verificationCode: json['verificationCode'] as String?,
    );
  }

  @override
  String toString() =>
      "MailVerificationRequestModel(email: $email,isMailSent: $isMailSent,verificationCode: $verificationCode)";

  @override
  int get hashCode => Object.hash(email, isMailSent, verificationCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailVerificationRequestModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          isMailSent == other.isMailSent &&
          verificationCode == other.verificationCode;
}
