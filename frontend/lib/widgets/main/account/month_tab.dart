import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class MonthTab extends StatelessWidget {
  const MonthTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Today", style: TextStyle(color: AppColors.grey, fontSize: 14),),
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
          SizedBox(height: 10,),
          Text("Tue,12 Feb 2022", style: TextStyle(color: AppColors.grey, fontSize: 14),),
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