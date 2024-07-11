class RevenueModel {
  String restaurantId;
  int revenue;

  RevenueModel({
    required this.restaurantId,
    required this.revenue,
  });

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'revenue': revenue,
    };
  }

  factory RevenueModel.fromJson(Map<String, dynamic> json) {
    return RevenueModel(
      restaurantId: json['restaurantId'] as String,
      revenue: json['revenue'] as int,
    );
  }

  @override
  String toString() =>
      "CreditRevenueModel(restaurantId: $restaurantId,revenue: $revenue)";

  @override
  int get hashCode => Object.hash(restaurantId, revenue);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevenueModel &&
          runtimeType == other.runtimeType &&
          restaurantId == other.restaurantId &&
          revenue == other.revenue;
}
