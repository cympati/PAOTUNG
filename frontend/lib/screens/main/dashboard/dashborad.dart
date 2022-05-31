import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/widgets/common/overview_pie_chart.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';

import '../../../core/data/models/category/piedata.dart';
import '../../../core/data/services/dashboard_expense_service.dart';
import '../../../core/data/services/dashboard_income_service.dart';
import '../../../widgets/common/default_text.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<PieData> _dashboardExpense = List.empty();
  List<PieData> _dashboardIncome = List.empty();

  @override
  void initState() {
    super.initState();

    _readJson();
  }

  Future<void> _readJson() async {
    var responseDashboardExpense = await GetPieDataExpenseService.getData();
    var responseDashboardIncome = await GetPieChartIncomeService.getData();
    if (mounted) {
      if (responseDashboardExpense is List<PieData>) {
        setState(() {
          _dashboardExpense = responseDashboardExpense;
        });
      }
      if (responseDashboardIncome is List<PieData>) {
        setState(() {
          _dashboardIncome = responseDashboardIncome;
        });
      } else {
        print(responseDashboardExpense.toString());
        print(responseDashboardIncome.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      const Padding(
        padding: EdgeInsets.only(left: 40, top: 70, right: 40),
        child: TextTitle(title: "My Finance", size: 24),
      ),
      Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
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
              Padding(
                  padding: const EdgeInsets.all(1),
                  child: _dashboardExpense.isEmpty
                      ? Card(
                          color: AppColors.lightgrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                              const DefaultText(text: 'category', color: false))
                      : OverviewPieChart(piedata: _dashboardExpense)),
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
              Padding(
                  padding: const EdgeInsets.all(1),
                  child: _dashboardIncome.isEmpty
                      ? Card(
                          color: AppColors.lightgrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:
                              const DefaultText(text: 'category', color: false))
                      : OverviewPieChart(piedata: _dashboardIncome)),
              const SizedBox(
                height: 24,
              ),
            ],
          )),
    ])));
  }
}
