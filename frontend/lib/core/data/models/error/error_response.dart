class ErrorResponse {
  bool success;
  String code;
  String message;
  // String error;

  ErrorResponse(this.success, this.code, this.message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['success'], 
      json['code'], 
      json['message'], 
      // json['error']
    );
  }
}

class ErrorStartResponse {
  bool success;
  String code;
  String message;

  ErrorStartResponse(this.success, this.code, this.message);

  factory ErrorStartResponse.fromJson(Map<String, dynamic> json) {
    return ErrorStartResponse(
        json['success'],
        json['code'],
        json['message']);
  }
}
