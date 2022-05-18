import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/screens/main/account/presentation/add_transaction.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/main/account/expense_tab.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  
  User _user = User(
      email: "",
      username: "",
      imagePath: "",
      balance: 0
    );

  void initState() {
    _readJson();
    super.initState();
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
                  child: const ExpenseTab(),
                )
              ),
            ],
          )
        ),  
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTransaction()));
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
