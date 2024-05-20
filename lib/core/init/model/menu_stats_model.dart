import 'package:haydi_express_customer/core/init/model/comment_model.dart';

class MenuStatsModel {
  String creationDate;
  int totalOrderCount;
  int likeRatio;
  String mostOrderTakingHour;
  int totalRevenue;
  List<CommentModel> comments;

  MenuStatsModel({
    required this.creationDate,
    required this.totalOrderCount,
    required this.likeRatio,
    required this.mostOrderTakingHour,
    required this.totalRevenue,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'creationDate': creationDate,
      'totalOrderCount': totalOrderCount,
      'likeRatio': likeRatio,
      'mostOrderTakingHour': mostOrderTakingHour,
      'totalRevenue': totalRevenue,
      'comments': comments,
    };
  }

  factory MenuStatsModel.fromJson(Map<String, dynamic> json) {
    return MenuStatsModel(
      creationDate: json['creationDate'] as String,
      totalOrderCount: json['totalOrderCount'] as int,
      likeRatio: json['likeRatio'] as int,
      mostOrderTakingHour: json['mostOrderTakingHour'] as String,
      totalRevenue: json['totalRevenue'] as int,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() =>
      "MenuStatsModel(creationDate: $creationDate,totalOrderCount: $totalOrderCount,likeRatio: $likeRatio,mostOrderTakingHour: $mostOrderTakingHour,totalRevenue: $totalRevenue,comments: $comments)";

  @override
  int get hashCode => Object.hash(creationDate, totalOrderCount, likeRatio,
      mostOrderTakingHour, totalRevenue, comments);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuStatsModel &&
          runtimeType == other.runtimeType &&
          creationDate == other.creationDate &&
          totalOrderCount == other.totalOrderCount &&
          likeRatio == other.likeRatio &&
          mostOrderTakingHour == other.mostOrderTakingHour &&
          totalRevenue == other.totalRevenue &&
          comments == other.comments;
}
