class AddCategoryResponse {
  bool success;
  String code;
  AddCategoryIdResponse data;

  AddCategoryResponse(
      {required this.code, required this.data, required this.success});

  factory AddCategoryResponse.fromJson(Map<String, dynamic> json) {
    return AddCategoryResponse(
        code: json['code'],
        data: AddCategoryIdResponse.fromJson(json['data']),
        success: json['success']);
  }
}

class AddCategoryIdResponse {
  int categoryId;

  AddCategoryIdResponse({required this.categoryId});

  factory AddCategoryIdResponse.fromJson(Map<String, dynamic> json) {
    return AddCategoryIdResponse(categoryId: json['category_id']);
  }
}
