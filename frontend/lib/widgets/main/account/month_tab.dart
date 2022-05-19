import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction_month.dart';
import 'package:paotung_frontend/core/data/services/transaction_month_service.dart';
import 'package:paotung_frontend/core/utils/life_cycle.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';
import 'package:paotung_frontend/widgets/main/transaction/transaction_box.dart';
import 'package:collection/collection.dart';

class MonthTab extends StatefulWidget {
  const MonthTab({Key? key}) : super(key: key);

  @override
  State<MonthTab> createState() => _MonthTabState();
}

class _MonthTabState extends State<MonthTab> {
  List<List<TransactionInfo>> _transaction = [];
  String formattedDateTimeNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void initState() {
    _readJson();
    super.initState();
    WidgetsBinding.instance?.addObserver(
        LifecycleEventHandler(resumeCallBack: () async =>  _readJson(), suspendingCallBack: () async => {})
    );
  }

  Future<void> _readJson() async {
    List<List<TransactionInfo>> responseTransactions =
        await GetTransactionMonthService.getData();

    setState(() {
      _transaction = responseTransactions.reversed.toList();
    });


    // _transaction.forEach((key, value) {
    //   print(value[0].dateString);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: _transaction.isEmpty
            ? const DefaultText(text: 'transactions', color: true)
            : Column(
                children: [
                  ..._transaction.map((m) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd').format(HttpDate.parse(m[0].dateString+' 01:02:03 GMT')) == formattedDateTimeNow
                              ? 'Today'
                              : m[0].dateString,
                          style: TextStyle(color: AppColors.grey, fontSize: 14),
                        ),
                        ...m.reversed.toList().map((e) {
                          return TransactionBox(
                              color: e.categoryColor,
                              text: e.categoryName,
                              title: e.tansactionName,
                              amount: e.amount);
                        }),
                      ],
                    );
                  }
                  ).toList(),
                ],
              ));
  }
}
