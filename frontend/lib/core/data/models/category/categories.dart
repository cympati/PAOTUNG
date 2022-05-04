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
      id: json["id"],
      name: json["name"],
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
