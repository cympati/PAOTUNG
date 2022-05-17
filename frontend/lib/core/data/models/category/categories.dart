class Categories {
  int id;
  String name;
  int color;

  Categories({
    required this.id,
    required this.name,
    required this.color,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json["category_id"],
      name: json["category_name"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color,
    };
  }
}

class TransactionType {
  List<Categories> expenseList;
  List<Categories> incomeList;

  TransactionType({required this.expenseList, required this.incomeList});
  factory TransactionType.fromJson(Map<String, dynamic> json) {
    var expenseTypeList =
        json['expense'] != null ? json['expense'] as List : List.empty();
    List<Categories> expenseTypeListTemp =
        expenseTypeList.map((e) => Categories.fromJson(e)).toList();

    var incomeTypeList =
        json['income'] != null ? json['income'] as List : List.empty();
    List<Categories> incomeTypeListTemp =
        incomeTypeList.map((e) => Categories.fromJson(e)).toList();

    return TransactionType(
      expenseList: expenseTypeListTemp,
      incomeList: incomeTypeListTemp,
    );
  }
}

class CategoryResponse {
  String message;
  bool success;
  String code;
  TransactionType data;

  CategoryResponse(
      {required this.success, required this.code, required this.data, required this.message});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      success: json['success'],
      code: json['code'],
      data: TransactionType.fromJson(json['data']),
      message: json['message'],
    );
  }
}
