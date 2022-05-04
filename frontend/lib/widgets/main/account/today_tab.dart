import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class TodayTab extends StatelessWidget {
  const TodayTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Today",
            style: TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          const TransactionBox(
            color: 4280731354,
            text: "Salary",
            title: "Part time",
            amount: 300.00,
          ),
          const TransactionBox(
            color: 4293673082,
            text: "Coffee",
            title: "Starbuck",
            amount: -150.00,
          ),
          const TransactionBox(
            color: 2321232132,
            text: "Personal",
            title: "Shopping",
            amount: -250.00,
          ),
        ],
      ),
    );
  }
}
