import 'package:haydi_express_customer/views/create_order/core/models/card_model.dart';

class PaymentModel {
  CardModel? cardData;
  int totalPrice;

  PaymentModel({
    required this.cardData,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardData': cardData?.toJson(),
      'totalPrice': totalPrice,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      cardData: json['cardData'] != null
          ? CardModel.fromJson(json['cardData'])
          : null,
      totalPrice: json['totalPrice'] as int,
    );
  }

  @override
  String toString() =>
      "PaymentModel(cardData: $cardData,totalPrice: $totalPrice)";

  @override
  int get hashCode => Object.hash(cardData, totalPrice);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModel &&
          runtimeType == other.runtimeType &&
          cardData == other.cardData &&
          totalPrice == other.totalPrice;
}
