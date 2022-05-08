import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Part-time', percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'From mom', percent: 30, color: const Color(0xfff8b250)),
    Data(name: 'Salary', percent: 15, color: Colors.black),
    Data(name: 'Invest', percent: 15, color: const Color(0xff13d38e)),
    Data(name: 'Saving', percent: 50, color: Colors.pink),
    Data(name: 'Others', percent: 50, color: Colors.purple),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}