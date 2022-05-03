import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/main/account/expense_tab.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double balance = 2000.75;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 250,
            backgroundColor: AppColors.mainColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Balance", style: TextStyle(fontSize: 15),),
                  Text(balance.toString(), style: TextStyle(fontSize: 30),),
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
                  child: const ExpenseTab(),
                )
              ),
            ],
          )),
        ],
      ),
    );
  }
}
