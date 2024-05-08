class CommentModel {
  String comment;
  int like;

  CommentModel({
    required this.comment,
    required this.like,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'like': like,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comment: json['comment'] as String,
      like: json['like'] as int,
    );
  }

  @override
  String toString() => "CommentModel(comment: $comment,like: $like)";

  @override
  int get hashCode => Object.hash(comment, like);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModel &&
          runtimeType == other.runtimeType &&
          comment == other.comment &&
          like == other.like;
}
