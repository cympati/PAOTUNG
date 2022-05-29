import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction_month.dart';
import 'package:paotung_frontend/core/data/services/transaction_today_service.dart';
import 'package:paotung_frontend/core/utils/life_cycle.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';

class TodayTab extends StatefulWidget {
  List<Transactions> transactionList;
  Function readJson;
  TodayTab({Key? key, required this.transactionList, required this.readJson})
      : super(key: key);

  @override
  State<TodayTab> createState() => _TodayTabState();
}

class _TodayTabState extends State<TodayTab> {
  List<Transactions> _transaction = [];

  void initState() {
    super.initState();
    widget.readJson();

    print("hhhhhhhh");
    print(_transaction);
    // WidgetsBinding.instance?.addObserver(
    //     LifecycleEventHandler(resumeCallBack: () async =>  _readJson(), suspendingCallBack: () async => {})
    // );
  }

  @override
  Widget build(BuildContext context) {
    _transaction = widget.transactionList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: _transaction.isEmpty
          ? DefaultText(text: 'transactions', color: true)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Today",
                  style: TextStyle(color: AppColors.grey, fontSize: 14),
                ),
                ..._transaction.map((transaction) {
                  return TransactionBox(
                      color: transaction.categoryColor,
                      text: transaction.categoryName,
                      title: transaction.transactionName,
                      amount: transaction.amount);
                }).toList()
              ],
            ),
    );
  }
}
