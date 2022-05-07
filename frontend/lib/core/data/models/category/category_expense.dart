import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Coffee', percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'Part-time', percent: 30, color: const Color(0xfff8b250)),
    Data(name: 'Shopping', percent: 15, color: Colors.black),
    Data(name: 'Spotify', percent: 15, color: const Color(0xff13d38e)),
    Data(name: 'Electric bill', percent: 50, color: Colors.pink),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}