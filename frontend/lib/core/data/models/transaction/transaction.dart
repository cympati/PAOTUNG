class CategoryInfo {
  String name;
  int color;
  CategoryInfo(this.name, this.color);
  factory CategoryInfo.fromJson(dynamic json) {
    return CategoryInfo(json["name"] as String, json["color"] as int);
  }
}
class Transactions {
  int id;
  String name;
  String amount;
  CategoryInfo category_info;

  Transactions({
    required this.id, 
    required this.name,
    required this.amount,
    required this.category_info
  });

  factory Transactions.fromJson(Map<String, dynamic> json) {

    return Transactions(
      id: json["id"], 
      name: json["name"],
      amount: json["amount"],
      category_info: CategoryInfo.fromJson(json["category_info"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id, 
      "name": name,
      "amount": amount,
      "category_info": category_info
    };
  }
}
