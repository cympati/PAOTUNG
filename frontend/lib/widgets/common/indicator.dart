import 'package:flutter/material.dart';

import '../../core/data/models/category/piedata.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key, required this.pieDatas}) : super(key: key);
  final List<PieData> pieDatas;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pieDatas
            .map(
              (data) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: buildIndicator(
                    color: Color(data.color),
                    text: data.name,
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
