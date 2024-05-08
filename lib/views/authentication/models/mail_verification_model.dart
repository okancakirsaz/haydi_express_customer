class MailVerificationModel {
  String email;
  bool isCodeTrue;
  String verificationCode;

  MailVerificationModel({
    required this.email,
    required this.isCodeTrue,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'isCodeTrue': isCodeTrue,
      'verificationCode': verificationCode,
    };
  }

  factory MailVerificationModel.fromJson(Map<String, dynamic> json) {
    return MailVerificationModel(
      email: json['email'] as String,
      isCodeTrue: json['isCodeTrue'] as bool,
      verificationCode: json['verificationCode'] as String,
    );
  }

  @override
  String toString() =>
      "MailVerificationModel(email: $email,isCodeTrue: $isCodeTrue,verificationCode: $verificationCode)";

  @override
  int get hashCode => Object.hash(email, isCodeTrue, verificationCode);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MailVerificationModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          isCodeTrue == other.isCodeTrue &&
          verificationCode == other.verificationCode;
}
