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

class ExpenseType {
  List<Categories> expense;

  ExpenseType({
    required this.expense,
  });

  factory ExpenseType.fromJson(Map<String, dynamic> json) {
    return ExpenseType(expense: json["expense"]);
  }
}

class CategoryResponse {
  bool success;
  String code;
   Map<String, dynamic> data;

  CategoryResponse(this.success, this.code, this.data);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var category = json['data'] ;
    Map<String, dynamic> tempcate =
        ExpenseType.fromJson(category) as Map<String, dynamic> ;

    return CategoryResponse(
      json['success'],
      json['code'],
      tempcate,
    );
  }
}


