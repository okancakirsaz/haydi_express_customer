class LogInModel {
  String mail;
  String password;
  bool isLoginSuccess;
  String? unSuccessfulReason;
  String? uid;

  LogInModel(
      {required this.mail,
      required this.password,
      required this.isLoginSuccess,
      this.unSuccessfulReason,
      this.uid});

  Map<String, dynamic> toJson() {
    return {
      'mail': mail,
      'password': password,
      'isLoginSuccess': isLoginSuccess,
      'unSuccessfulReason': unSuccessfulReason,
      'uid': uid
    };
  }

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      mail: json['mail'] as String,
      password: json['password'] as String,
      isLoginSuccess: json['isLoginSuccess'] as bool,
      unSuccessfulReason: json['unSuccessfulReason'] as String?,
      uid: json['uid'] as String?,
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
