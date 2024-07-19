import '../../create_order/core/models/order_model.dart';

class CancelOrderModel {
  OrderModel order;
  String reason;

  CancelOrderModel({
    required this.order,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'order': order.toJson(),
      'reason': reason,
    };
  }

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) {
    return CancelOrderModel(
      order: OrderModel.fromJson(json['order']),
      reason: json['reason'] as String,
    );
  }

  @override
  String toString() => "CancelOrderModel(order: $order,reason: $reason)";

  @override
  int get hashCode => Object.hash(order, reason);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CancelOrderModel &&
          runtimeType == other.runtimeType &&
          order == other.order &&
          reason == other.reason;
}
