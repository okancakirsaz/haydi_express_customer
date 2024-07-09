import 'package:haydi_express_customer/core/init/model/menu_model.dart';

class BucketElementModel {
  MenuModel menuElement;
  int count;

  BucketElementModel({
    required this.menuElement,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuElement': menuElement.toJson(),
      'count': count,
    };
  }

  factory BucketElementModel.fromJson(Map<String, dynamic> json) {
    return BucketElementModel(
      menuElement: MenuModel.fromJson(json['menuElement']),
      count: json['count'] as int,
    );
  }

  @override
  String toString() =>
      "BucketElementModel(menuElement: $menuElement,count: $count)";

  @override
  int get hashCode => Object.hash(menuElement, count);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BucketElementModel &&
          runtimeType == other.runtimeType &&
          menuElement == other.menuElement &&
          count == other.count;
}
