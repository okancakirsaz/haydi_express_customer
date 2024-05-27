class SuggestionModel {
  String name;
  bool isRestaurant;
  bool isOnDiscount;
  bool isBoosted;
  int price;
  int discountAmount;
  String elementId;

  SuggestionModel({
    required this.name,
    required this.isRestaurant,
    required this.isOnDiscount,
    required this.isBoosted,
    required this.price,
    required this.discountAmount,
    required this.elementId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isRestaurant': isRestaurant,
      'isOnDiscount': isOnDiscount,
      'isBoosted': isBoosted,
      'price': price,
      'discountAmount': discountAmount,
      'elementId': elementId,
    };
  }

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      name: json['name'] as String,
      isRestaurant: json['isRestaurant'] as bool,
      isOnDiscount: json['isOnDiscount'] as bool,
      isBoosted: json['isBoosted'] as bool,
      price: json['price'] as int,
      discountAmount: json['discountAmount'] as int,
      elementId: json['elementId'] as String,
    );
  }

  @override
  String toString() =>
      "SuggestionModel(name: $name,isRestaurant: $isRestaurant,isOnDiscount: $isOnDiscount,isBoosted: $isBoosted,price: $price,discountAmounth: $discountAmount,elementId: $elementId)";

  @override
  int get hashCode => Object.hash(name, isRestaurant, isOnDiscount, isBoosted,
      price, discountAmount, elementId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuggestionModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          isRestaurant == other.isRestaurant &&
          isOnDiscount == other.isOnDiscount &&
          isBoosted == other.isBoosted &&
          price == other.price &&
          discountAmount == other.discountAmount &&
          elementId == other.elementId;
}
