class ErrorResponse {
  bool success;
  String code;
  String message;
  String error;

  ErrorResponse(this.success, this.code, this.message, this.error);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['success'], 
      json['code'], 
      json['message'], 
      json['error']);
  }
}
