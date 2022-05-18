class DeleteResponse {
  bool success;
  String message;
  String code;

  DeleteResponse({
    required this.success,
    required this.message,
    required this.code,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(
      success: json['success'],
      message: json['message'],
      code: json['code'],
    );
  }
}