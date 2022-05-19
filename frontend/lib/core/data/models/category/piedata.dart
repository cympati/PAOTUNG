// double reciprocal(double d) => 1 / d;

class PieData {
  String name;
  double percent;
  int color;

  PieData({required this.name, required this.percent, required this.color});

  factory PieData.fromJson(Map<String, dynamic> json) {
    print(json["percent"]);
    return PieData(
      name: json["category_name"],
      percent: json["percent"].toDouble() ,
      color: json["category_color"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category_name": name,
      "percent": percent,
      "category_color": color,
    };
  }
}

class PieDataResponse {
  bool success;
  String code;
  List<PieData> piedata;
  PieDataResponse(this.success, this.code, this.piedata);

  factory PieDataResponse.fromJson(Map<String, dynamic> json) {
    var category = json['data'] as List;
    List<PieData> data =
        category.map((e) => PieData.fromJson(e)).toList();

    return PieDataResponse(
      json['success'],
      json['code'],
      data,
    );
  }
}
