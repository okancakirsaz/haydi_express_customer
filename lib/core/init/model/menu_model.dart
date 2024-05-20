import 'package:haydi_express_customer/core/init/model/menu_stats_model.dart';

class MenuModel {
  String name;
  int price;
  String photoUrl;
  String content;
  String restaurantUid;
  bool isOnDiscount;
  int? discountAmount;
  String? discountFinishDate;
  String menuId;
  List<dynamic> tags;
  MenuStatsModel stats;
  String? boostExpireDate;
  String restaurantName;

  MenuModel({
    required this.name,
    required this.price,
    required this.photoUrl,
    required this.content,
    required this.tags,
    required this.restaurantUid,
    required this.isOnDiscount,
    required this.discountAmount,
    required this.discountFinishDate,
    required this.menuId,
    required this.stats,
    this.boostExpireDate,
    required this.restaurantName,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'photoUrl': photoUrl,
      'content': content,
      'restaurantUid': restaurantUid,
      'isOnDiscount': isOnDiscount,
      'discountAmount': discountAmount,
      'discountFinishDate': discountFinishDate,
      'menuId': menuId,
      'tags': tags,
      'stats': stats.toJson(),
      'boostExpireDate': boostExpireDate,
      'restaurantName': restaurantName
    };
  }

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      name: json['name'] as String,
      price: json['price'] as int,
      photoUrl: json['photoUrl'] as String,
      content: json['content'] as String,
      restaurantUid: json['restaurantUid'] as String,
      isOnDiscount: json['isOnDiscount'] as bool,
      discountAmount: json['discountAmount'] as int?,
      discountFinishDate: json['discountFinishDate'] as String?,
      menuId: json['menuId'] as String,
      tags: json['tags'] as List<dynamic>,
      stats: MenuStatsModel.fromJson(json['stats']),
      boostExpireDate: json['boostExpireDate'] as String?,
      restaurantName: json['restaurantName'] as String,
    );
  }

  @override
  String toString() =>
      "MenuModel(name: $name,price: $price,photoUrl: $photoUrl,content: $content,restaurantUid: $restaurantUid,isOnDiscount: $isOnDiscount,discountAmount: $discountAmount,discountFinishDate: $discountFinishDate,menuId: $menuId,stats: $stats)";

  @override
  int get hashCode => Object.hash(name, price, photoUrl, content, restaurantUid,
      isOnDiscount, discountAmount, discountFinishDate, menuId, stats);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          price == other.price &&
          photoUrl == other.photoUrl &&
          content == other.content &&
          restaurantUid == other.restaurantUid &&
          isOnDiscount == other.isOnDiscount &&
          discountAmount == other.discountAmount &&
          discountFinishDate == other.discountFinishDate &&
          menuId == other.menuId &&
          stats == other.stats;
}
