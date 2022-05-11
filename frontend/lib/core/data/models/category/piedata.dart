import 'package:flutter/src/widgets/container.dart';

class PieData {
  String name;

  double percent;

  int color;


  PieData({required this.name, required this.percent, required this.color});

  factory PieData.fromJson(Map<String, dynamic> json) {

    return PieData(
      name: json["name"],
      percent: json["percent"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "percent" : percent,
      "color": color,
    };
  }

  static asMap() {}

  static map(Container Function(dynamic data) param0) {}
}