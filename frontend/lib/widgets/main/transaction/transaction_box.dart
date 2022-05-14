import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/category/color_dot.dart';

class TransactionBox extends StatelessWidget {
  final String title;
  final String text;
  final int color;
  final String amount;
  const TransactionBox({
    Key? key,
    required this.color,
    required this.text,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double number = amount;
    // String str = number.toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Row(
        children: [
          Row(
            children: [
              ColorDots(color: color),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Gap(5),
                  Text(
                    text,
                    style: TextStyle(fontSize: 10, color: AppColors.grey),
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(fontSize: 16, color: AppColors.thirdaryColor),
          )
        ],
      ),
    );
  }
}
