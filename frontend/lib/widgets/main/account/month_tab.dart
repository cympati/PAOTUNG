import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction_month.dart';
import 'package:paotung_frontend/core/data/services/transaction_month_service.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';
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
      _transaction = responseTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: _transaction.isEmpty
            ? DefaultText(text: 'transactions')
            : Column(
                
                children: [
                  ..._transaction.map((transaction) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.dateString,
                          style: TextStyle(color: AppColors.grey, fontSize: 14),
                        ),
                        ..._transaction.map((transaction) {
                          return TransactionBox(
                              color: transaction.categoryColor,
                              text: transaction.categoryName,
                              title: transaction.tansactionName,
                              amount: transaction.amount);
                        }),
                      ],
                    );
                  }).toList()
                ],
              ));
  }
}
