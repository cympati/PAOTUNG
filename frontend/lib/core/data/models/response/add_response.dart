class TransactionId {
  int id;

  TransactionId({required this.id});

  factory TransactionId.fromJson(Map<String, dynamic> json) {
    return TransactionId(
      id: json["transaction_id"],
    );
  }
}

class AddTransactionResponse {
  bool success;
  String code;
  String message;
  TransactionId data;

  AddTransactionResponse(
      {required this.success,
      required this.code,
      required this.data,
      required this.message});

  factory AddTransactionResponse.fromJson(Map<String, dynamic> json) {
    return AddTransactionResponse(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      data: TransactionId.fromJson(json['data']),
    );
  }
}


class CategoryId {
  int id;

  CategoryId({required this.id});

  factory CategoryId.fromJson(Map<String, dynamic> json) {
    return CategoryId(
      id: json["category_id"],
    );
  }
}

class AddCategoryResponse {
  bool success;
  String code;
  String message;
  TransactionId data;

  AddCategoryResponse(
      {required this.success,
        required this.code,
        required this.data,
        required this.message});

  factory AddCategoryResponse.fromJson(Map<String, dynamic> json) {
    return AddCategoryResponse(
      success: json['success'],
      code: json['code'],
      message: json['message'],
      data: TransactionId.fromJson(json['data']),
    );
  }
}

class NotificationId {
  int id;

  NotificationId({required this.id});

  factory NotificationId.fromJson(Map<String, dynamic> json) {
    return NotificationId(
      id: json["notification_id"],
    );
  }
}

class AddNotiResponse {
  bool success;
  String message;
  NotificationId data;

  AddNotiResponse({
    required this.success,
    required this.message,
    required this.data,

  });

  factory AddNotiResponse.fromJson(Map<String, dynamic> json) {
    return AddNotiResponse(
      success: json['success'],
      message: json['message'],
      data: NotificationId.fromJson(json['data']),
    );
  }
}