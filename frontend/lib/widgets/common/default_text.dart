import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final bool color;
  const DefaultText({ Key? key, required this.text , required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      alignment: Alignment.center,
      child: Text(
        "You don't have any "  + text, 
        style: TextStyle(
          color: color ? AppColors.grey :Colors.black38
        ),
      ),
    );
  }
}