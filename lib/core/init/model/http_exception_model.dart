class HttpExceptionModel {
  String response;
  int status;
  String message;
  String name;

  HttpExceptionModel({
    required this.response,
    required this.status,
    required this.message,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'status': status,
      'message': message,
      'name': name,
    };
  }

  factory HttpExceptionModel.fromJson(Map<String, dynamic> json) {
    return HttpExceptionModel(
      response: json['response'] as String,
      status: json['status'] as int,
      message: json['message'] as String,
      name: json['name'] as String,
    );
  }

  @override
  String toString() =>
      "HttpExceptionModel(response: $response,status: $status,message: $message,name: $name)";

  @override
  int get hashCode => Object.hash(response, status, message, name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpExceptionModel &&
          runtimeType == other.runtimeType &&
          response == other.response &&
          status == other.status &&
          message == other.message &&
          name == other.name;
}
