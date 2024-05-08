class ForgotPasswordModel {
  bool isMailSent;
  String mail;
  String uid;

  ForgotPasswordModel({
    required this.isMailSent,
    required this.mail,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'isMailSent': isMailSent,
      'mail': mail,
      'uid': uid,
    };
  }

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      isMailSent: json['isMailSent'] as bool,
      mail: json['mail'] as String,
      uid: json['uid'] as String,
    );
  }

  @override
  String toString() =>
      "ForgotPasswordModel(isMailSent: $isMailSent,mail: $mail,uid: $uid)";

  @override
  int get hashCode => Object.hash(isMailSent, mail, uid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForgotPasswordModel &&
          runtimeType == other.runtimeType &&
          isMailSent == other.isMailSent &&
          mail == other.mail &&
          uid == other.uid;
}
