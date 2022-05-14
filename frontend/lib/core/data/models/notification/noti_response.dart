class AddNotiResponse {
  bool success;
  String message;
  AddNotiResponse data;
  String userId;

  AddNotiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.userId,
  });

  factory AddNotiResponse.fromJson(Map<String, dynamic> json) {
    return AddNotiResponse(
      success: json['success'],
      message: json['message'],
      userId: json['userId'],
      data: AddNotiResponse.fromJson(json['data']),
    );
  }
}


