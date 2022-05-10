import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction.dart';
import 'package:paotung_frontend/core/data/services/transaction_month_service.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';
import 'package:collection/collection.dart';

class MonthTab extends StatefulWidget {
  const MonthTab({Key? key}) : super(key: key);

  @override
  State<MonthTab> createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {

  List<Transactions> _transaction = [];
  
  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseTransactions = await GetTransactionMonthService.getData();
    
    setState(() {
       _transaction = GetTransactionMonthService.getTransactionsMonth(responseTransactions);
       
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
          // const SizedBox(
          //   height: 10,
          // ),
          // Container(height: 20,),
          // Text(
          //   "Tue,12 Feb 2022",
          //   style: TextStyle(color: AppColors.grey, fontSize: 14),
          // ),
          // const TransactionBox(
          //   color: 2394369343,
          //   text: "Salary",
          //   title: "Part time",
          //   amount: 300.00,
          // ),
          // const TransactionBox(
          //   color: 4294361096,
          //   text: "Coffee",
          //   title: "Starbuck",
          //   amount: -150.00,
          // ),
          // const TransactionBox(
          //   color: 4286141768,
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
