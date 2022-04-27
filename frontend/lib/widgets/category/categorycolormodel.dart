import 'package:flutter/cupertino.dart';

class CategoryColor {
  var title;
  Color color;

  CategoryColor({required this.title, required this.color});
}

List<CategoryColor> items = [
  CategoryColor(title: "Red", color: Color(0xFFF44336)),
  CategoryColor(title: "Pink", color: Color(0xFFE91E63)),
  CategoryColor(title: "Purple", color: Color(0xFF9C27B0)),
  CategoryColor(title: "Indigo", color: Color(0xFF3F51B5)),
  CategoryColor(title: "Light-blue", color: Color(0xFF03A0F4)),
  CategoryColor(title: "Teal", color: Color(0xFF009688)),
  CategoryColor(title: "Green", color: Color(0xFF4CAF50)),
  CategoryColor(title: "Light-green", color: Color(0xFF8BC34A)),
  CategoryColor(title: "lime", color: Color(0xFFCDDC39)),
  CategoryColor(title: "Yellow", color: Color(0xFFFFEB3B)),
  CategoryColor(title: "Amber", color: Color(0xFFFFc107)),
  CategoryColor(title: "Orange", color: Color(0xFFFF9800)),
];
 