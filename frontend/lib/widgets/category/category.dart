import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final Color color;
  final String text;

  const Category({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Row(
        children: [
          Row(
            children: [
              ColorDots(color: color),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(text)],
              )
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  // Container ColorDot(
  //   Color color,
  // ) {
  //   return Container(
  //     height: 20,
  //     width: 20,
  //     decoration:
  //         BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
  //   );
  // }
}

class ColorDots extends StatelessWidget {
  final Color color;
  const ColorDots({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    );
  }
}
