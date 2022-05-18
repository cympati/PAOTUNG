import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class TextTitle extends StatelessWidget {
  final String title;
  final double size;
  const TextTitle({ Key? key, required this.title, required this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( top: 10, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: size,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            
    );
  }
}