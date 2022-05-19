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