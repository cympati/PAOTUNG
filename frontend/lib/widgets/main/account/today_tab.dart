import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction.dart';
import 'package:paotung_frontend/core/data/services/transaction_today_service.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class TodayTab extends StatefulWidget {
  const TodayTab({Key? key}) : super(key: key);

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  List<Transactions> _transaction = [];

  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseTransactions = await GetTransactionTodayService.getData();
    
      setState(() {
        _transaction = GetTransactionTodayService.getTransactionsToday(responseTransactions);
      });
    }

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
          // const TransactionBox(
          //   color: 4280731354,
          //   text: "Salary",
          //   title: "Part time",
          //   amount: 300.00,
          // ),
          // const TransactionBox(
          //   color: 4293673082,
          //   text: "Coffee",
          //   title: "Starbuck",
          //   amount: -150.00,
          // ),
          // const TransactionBox(
          //   color: 2321232132,
          //   text: "Personal",
          //   title: "Shopping",
          //   amount: -250.00,
          // ),
          ..._transaction.map((transaction) {
            return TransactionBox(
              color: transaction.category_info.color, 
              text: transaction.category_info.name, 
              title: transaction.name, 
              amount: transaction.amount
            );
          })
        ],
      ),
    );
  }
}
