import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/piedata.dart';
import 'package:paotung_frontend/widgets/common/overview_pie_chart.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';

import '../../../core/data/services/dashboard_expense_service.dart';
import '../../../core/data/services/dashboard_income_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<PieData> _dashboardExpense = [];
  List<PieData> _dashboardIncome = [];

  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseDashboardExpense = await GetDashboardExpenseService.getData();
    var responseDashboardIncome = await GetDashboardIncomeService.getData();
    if (mounted) {
      setState(() {
        _dashboardExpense = GetDashboardExpenseService.getPieData(responseDashboardExpense);
        _dashboardIncome = GetDashboardIncomeService.getPieData(responseDashboardIncome);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 32, top: 32, right: 32),
        child: TextTitle(title: "My Finance", size: 24),
      ),
      // const SizedBox(
      //   height: 24,
      // ),
      Container(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            children: <Widget>[
              Container(
                height: 48,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Expenses Each Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              ..._dashboardExpense.map((piedata) {
          return OverviewPieChart(name: piedata.name , color : piedata.color , percent : piedata.percent);
          }).toList(),
              
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 48,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Income Each Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              ..._dashboardIncome.map((piedata) {
          return OverviewPieChart(name: piedata.name , color : piedata.color , percent : piedata.percent);
          }).toList(),
              const SizedBox(
                height: 40,
              ),
            ],
          )),
    ])));
  }
}
