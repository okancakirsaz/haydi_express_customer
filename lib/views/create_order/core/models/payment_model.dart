import 'package:haydi_express_customer/views/create_order/core/models/card_model.dart';
import 'package:haydi_express_customer/views/create_order/core/models/revenue_model.dart';

class PaymentModel {
  CardModel? cardData;
  List<RevenueModel> revenues;
  int totalPrice;

  PaymentModel({
    required this.cardData,
    required this.revenues,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardData': cardData?.toJson(),
      'revenues': revenues.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      cardData: json['cardData'] != null
          ? CardModel.fromJson(json['cardData'])
          : null,
      revenues: (json['revenues'] as List<dynamic>)
          .map((e) => RevenueModel.fromJson(e))
          .toList(),
      totalPrice: json['totalPrice'] as int,
    );
  }

  @override
  String toString() =>
      "PaymentModel(cardData: $cardData,revenues: $revenues,totalPrice: $totalPrice)";

  @override
  int get hashCode => Object.hash(cardData, revenues, totalPrice);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModel &&
          runtimeType == other.runtimeType &&
          cardData == other.cardData &&
          revenues == other.revenues &&
          totalPrice == other.totalPrice;
}
