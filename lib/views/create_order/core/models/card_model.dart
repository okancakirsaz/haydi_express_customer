class CardModel {
  String cardHolder;
  String cardNumber;
  String cvv;
  String expireDate;

  CardModel({
    required this.cardHolder,
    required this.cardNumber,
    required this.cvv,
    required this.expireDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'expireDate': expireDate,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardHolder: json['cardHolder'] as String,
      cardNumber: json['cardNumber'] as String,
      cvv: json['cvv'] as String,
      expireDate: json['expireDate'] as String,
    );
  }

  @override
  String toString() =>
      "CreditCardModel(cardHolder: $cardHolder,cardNumber: $cardNumber,cvv: $cvv,expireDate: $expireDate)";

  @override
  int get hashCode => Object.hash(cardHolder, cardNumber, cvv, expireDate);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModel &&
          runtimeType == other.runtimeType &&
          cardHolder == other.cardHolder &&
          cardNumber == other.cardNumber &&
          cvv == other.cvv &&
          expireDate == other.expireDate;
}
