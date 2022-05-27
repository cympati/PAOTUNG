import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction.dart';
import 'package:paotung_frontend/core/data/models/transaction/transaction_month.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/transaction_month_service.dart';
import 'package:paotung_frontend/core/data/services/transaction_today_service.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/core/utils/app_builder.dart';
import 'package:paotung_frontend/core/utils/life_cycle.dart';
import 'package:paotung_frontend/screens/main/account/presentation/add_transaction.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/main/account/expense_tab.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late List<List<TransactionInfo>> _transactionMonthList = [];
  late List<Transactions> _transactionDayList = [];

  Future<void> _readTransactionMonthJson() async {
    List<List<TransactionInfo>> responseTransactions =
    await GetTransactionMonthService.getData();

    setState(() {
      _transactionMonthList = responseTransactions.reversed.toList();
    });
    print("Month");

    // print(_transactionMonthList.toString());
  }

  Future<void> _readTransactionDayJson() async {
    var responseTransactions = await GetTransactionTodayService.getData();

    setState(() {
      _transactionDayList = responseTransactions.reversed.toList();
    });

    print("Day");
  }

  User _user = User(
      email: "",
      username: "",
      imagePath: "",
      balance: 0
  );

  @override
  void initState() {
    super.initState();
    _readJson();
    _readTransactionMonthJson();
    _readTransactionDayJson();
    print("testtestttedgyshld");
    debugPrint(_transactionMonthList.toString());

  }

  void refresh() {
    debugPrint("1112");
    _readJson();
    AppBuilder.of(context)?.rebuild();
  }
  Future<void> _readJson() async {
    var responseUser = await GetUser.getData();
    if (mounted) {
      setState(() {
        _user = responseUser;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 120,
            floating: true,
            pinned: true,
            expandedHeight: 250,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Balance", style: TextStyle(fontSize: 15),),
                  Text(_user.balance.toString(), style: TextStyle(fontSize: 30),),
                ],
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 32),
                        child: AppBuilder(builder: (context)  {
                          return TransactionsTab(transactionMonthList: _transactionMonthList, transactionDayList: _transactionDayList, readTransactionMonthJson: _readTransactionMonthJson, readTransactionDayJson:_readTransactionDayJson);
                        }),
                      )
                  ),
                ],
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("222");
          refresh();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTransaction(backTrigger: refresh,readMonthJson:_readTransactionMonthJson, readDayJson:_readTransactionDayJson,)));
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
