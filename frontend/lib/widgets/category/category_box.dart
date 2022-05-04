import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/theme.dart';

class CategoryBox extends StatelessWidget {
  final int color;
  final String name;

  const CategoryBox({Key? key, required this.color, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40,top: 0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.lightgrey))),
          child: Row(
            children: [
              Row(
                children: [
                  ColorDots(color: color),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),)],
                  )
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: () => print("delete this category"),
              ),
            ],
          ),
        ));
  }
}

class ColorDots extends StatelessWidget {
  final int color;

  const ColorDots({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(color)),
    );
  }
}
