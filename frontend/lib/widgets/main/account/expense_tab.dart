import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction_month.dart';
import 'package:paotung_frontend/core/utils/extensions.dart';
import 'package:paotung_frontend/widgets/main/account/month_tab.dart';
import 'package:paotung_frontend/widgets/main/account/today_tab.dart';

enum Tab { today, month }

class TransactionsTab extends StatefulWidget {
  List<List<TransactionInfo>> transactionMonthList;
  List<Transactions> transactionDayList;
  Function readTransactionMonthJson;
  Function readTransactionDayJson;

  TransactionsTab({ Key? key , required this.transactionMonthList, required this.transactionDayList, required this.readTransactionDayJson, required this.readTransactionMonthJson}) : super(key: key);

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  List<List<TransactionInfo>> _transactionMonth = [];
  List<Transactions> _transactionDayList = [];
  Tab currentTab = Tab.today;

  void initState() {
    super.initState();
    // widget.readTransactionDayJson();
    // widget.readTransactionMonthJson();
    setState(() {

    });

    print("TEst");
    print(widget.transactionDayList.toString());
  }

  @override
  Widget build(BuildContext context) {
    _transactionMonth = widget.transactionMonthList;
    _transactionDayList = widget.transactionDayList;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 23,),
          child: Container(
            height: 40,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.lightgrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Tab.values
                  .map(
                    (e) => Expanded(
                      child: TabItem((e.name.titleCaseSingle()),
                          value: e,
                          groupValue: currentTab,
                          onChanged: (value) =>
                              setState(() => currentTab = value)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        IndexedStack(
          index: currentTab.index,
          children: [TodayTab(transactionList: _transactionDayList, readJson: widget.readTransactionDayJson,), MonthTab(transactionList: _transactionMonth,readJson: widget.readTransactionMonthJson,)],
        ),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final Tab value;
  final Tab groupValue;
  final ValueChanged<Tab> onChanged;

  const TabItem(
    this.title, {
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainColor : AppColors.lightgrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    ).onTap(() => onChanged(value));
  }
}