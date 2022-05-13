class Categories {
  int id;
  String name;
  int color;

  Categories(
      {required this.id,
        required this.name,
        required this.color,});

  factory Categories.fromJson(Map<String, dynamic> json) {

    return Categories(
      id: json["category_id"],
      name: json["category_name"],
      color: json["category_color"],
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

class CategoryResponse{
  bool success;
  String code;
  List<Categories> data;

  CategoryResponse(this.success, this.code, this.data);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    var category = json['data'] as List;
    List<Categories> tempcate = category.map((e) => Categories.fromJson(e)).toList();
    
    return CategoryResponse(
      json['success'], 
      json['code'], 
      tempcate, 
      );
  }

}