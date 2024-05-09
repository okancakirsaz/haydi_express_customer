class CustomerModel {
  String email;
  String password;
  bool isAgreementsAccepted;
  String name;
  String phoneNumber;
  String gender;
  bool isPhoneVerified;
  String uid;

  CustomerModel({
    required this.email,
    required this.password,
    required this.isAgreementsAccepted,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.isPhoneVerified,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'isAgreementsAccepted': isAgreementsAccepted,
      'name': name,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'isPhoneVerified': isPhoneVerified,
      'uid': uid,
    };
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      email: json['email'] as String,
      password: json['password'] as String,
      isAgreementsAccepted: json['isAgreementsAccepted'] as bool,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      isPhoneVerified: json['isPhoneVerified'] as bool,
      uid: json['uid'] as String,
    );
  }

  @override
  String toString() =>
      "CustomerModel(email: $email,password: $password,isAgreementsAccepted: $isAgreementsAccepted,name: $name,phoneNumber: $phoneNumber,gender: $gender,isPhoneVerified: $isPhoneVerified,uid: $uid)";

  @override
  int get hashCode => Object.hash(email, password, isAgreementsAccepted, name,
      phoneNumber, gender, isPhoneVerified, uid);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          isAgreementsAccepted == other.isAgreementsAccepted &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          gender == other.gender &&
          isPhoneVerified == other.isPhoneVerified &&
          uid == other.uid;
}
