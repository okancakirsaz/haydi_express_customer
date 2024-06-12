class AddressModel {
  String name;
  String city;
  String state;
  String neighborhood;
  String street;
  String buildingNumber;
  String doorNumber;
  String addressDirection;
  String floor;
  double? lat;
  double? long;
  bool isVerifiedFromCourier;
  String? courierAddressDirection;
  String uid;
  String addressOwner;

  AddressModel({
    required this.name,
    required this.city,
    required this.state,
    required this.neighborhood,
    required this.street,
    required this.buildingNumber,
    required this.doorNumber,
    required this.floor,
    required this.addressDirection,
    this.lat,
    this.long,
    required this.isVerifiedFromCourier,
    this.courierAddressDirection,
    required this.uid,
    required this.addressOwner,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city,
      'state': state,
      'neighborhood': neighborhood,
      'street': street,
      'buildingNumber': buildingNumber,
      'doorNumber': doorNumber,
      'floor': floor,
      'addressDirection': addressDirection,
      'lat': lat,
      'long': long,
      'isVerifiedFromCourier': isVerifiedFromCourier,
      'courierAddressDirection': courierAddressDirection,
      'uid': uid,
      'addressOwner': addressOwner,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      neighborhood: json['neighborhood'] as String,
      street: json['street'] as String,
      buildingNumber: json['buildingNumber'] as String,
      doorNumber: json['doorNumber'] as String,
      floor: json['floor'] as String,
      addressDirection: json['addressDirection'] as String,
      lat: json['lat'] as double?,
      long: json['long'] as double?,
      isVerifiedFromCourier: json['isVerifiedFromCourier'] as bool,
      courierAddressDirection: json['courierAddressDirection'] as String?,
      uid: json['uid'] as String,
      addressOwner: json['addressOwner'] as String,
    );
  }

  @override
  String toString() =>
      "AddressModel(name: $name,city: $city,state: $state,neighborhood: $neighborhood,buildingNumber: $buildingNumber,doorNumber: $doorNumber,addressDirection: $addressDirection,lat: $lat,long: $long,isVerifiedFromCourier: $isVerifiedFromCourier,courierAddressDirection: $courierAddressDirection,uid: $uid,addressOwner: $addressOwner)";

  @override
  int get hashCode => Object.hash(
      name,
      city,
      state,
      neighborhood,
      buildingNumber,
      doorNumber,
      addressDirection,
      lat,
      long,
      isVerifiedFromCourier,
      courierAddressDirection,
      uid,
      addressOwner);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          city == other.city &&
          state == other.state &&
          neighborhood == other.neighborhood &&
          buildingNumber == other.buildingNumber &&
          doorNumber == other.doorNumber &&
          addressDirection == other.addressDirection &&
          lat == other.lat &&
          long == other.long &&
          isVerifiedFromCourier == other.isVerifiedFromCourier &&
          courierAddressDirection == other.courierAddressDirection &&
          uid == other.uid &&
          addressOwner == other.addressOwner;
}
