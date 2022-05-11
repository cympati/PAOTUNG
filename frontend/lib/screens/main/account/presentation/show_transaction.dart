import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class ShowTransaction extends StatefulWidget {
  const ShowTransaction({Key? key}) : super(key: key);

  @override
  State<ShowTransaction> createState() => _ShowTransactionState();
}

class _ShowTransactionState extends State<ShowTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const [
          // TransactionBox(
          //   color: 4280731354,
          //   text: "Salary",
          //   title: "Part time",
          //   amount: 300.00,
          // ),
          // TransactionBox(
          //   color: 4293673082,
          //   text: "Coffee",
          //   title: "Starbuck",
          //   amount: 150.00,
          // ),
          // TransactionBox(
          //   color: 2321232132,
          //   text: "Personal",
          //   title: "Shopping",
          //   amount: 250.00,
          // ),
        ],
      ),
    );
  }
}
