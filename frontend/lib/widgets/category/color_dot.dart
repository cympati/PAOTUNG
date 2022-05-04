import 'package:flutter/material.dart';

class ColorDots extends StatelessWidget {
  final int color;
  const ColorDots({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(color)),
    );
  }
}
