class HttpExceptionModel {
  int status;
  String message;

  HttpExceptionModel({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory HttpExceptionModel.fromJson(Map<String, dynamic> json) {
    return HttpExceptionModel(
      status: json['status'] as int,
      message: json['message'] as String,
    );
  }

  @override
  String toString() => "HttpExceptionModel(status: $status,message: $message)";

  @override
  int get hashCode => Object.hash(status, message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpExceptionModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          message == other.message;
}
