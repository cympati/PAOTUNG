import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Coffee', percent:10, color: 4278359022),
    Data(name: 'Project', percent: 20, color: 4294488656),
    Data(name: 'Shopping', percent: 10, color: 4278190080),
    // Data(name: 'Spotify', percent: 15, color: 4279489422),
    Data(name: 'Electric bill', percent: 30, color: 3911083007),
    Data(name: 'Others', percent: 30, color: 2619846911),
  ];
}

class Data {
  final String name;

  final double percent;

  final int color;

  Data({required this.name, required this.percent, required this.color});
}