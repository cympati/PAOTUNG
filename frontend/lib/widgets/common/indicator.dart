import 'package:paotung_frontend/core/data/models/category/piedata.dart';
import 'package:flutter/material.dart';

import '../../core/data/models/category/category_income.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: PieData
            .map(
              (data) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: buildIndicator(
                    color: Color(data.color),
                    text: data.name,
                    // isSquare: true,
                  ),),
            )
            .toList(),
      );

  Widget buildIndicator({
    required Color color,
    required String text,
    bool isSquare = false,
    double size = 12,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      );
}
