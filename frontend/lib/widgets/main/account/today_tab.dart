import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class TodayTab extends StatelessWidget {
  const TodayTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Today",
            style: TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          TransactionBox(
            color: Color(0xFF26C6DA),
            text: "Salary",
            title: "Part time",
            amount: "+300.00",
          ),
          TransactionBox(
            color: Color(0xFF795548),
            text: "Coffee",
            title: "Starbuck",
            amount: "-150.00",
          ),
          TransactionBox(
            color: Color(0xFFEC407A),
            text: "Personal",
            title: "Shopping",
            amount: "-250.00",
          ),
        ],
      ),
    );
  }
}
