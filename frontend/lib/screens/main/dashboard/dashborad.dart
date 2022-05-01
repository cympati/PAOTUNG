import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/common/overview_pie_chart.dart';
import '../../widgets/common/bar_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        height: 100,
        alignment: Alignment.centerLeft,
        child: Text(
          "My Finances",
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      
      const SizedBox(height: 24,),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 48,
              //   alignment: Alignment.centerLeft,
              //   child: const Text(
              //     "Weekly Financial Overview",
              //     style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       fontSize: 16,
              //     ),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // BarChartTwo(),
              //const SizedBox(height: 24,),
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
              const OverviewPieChart(),
              const SizedBox(height: 24,),
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
              const OverviewPieChart(),
              const SizedBox(height: 40,),
            ],
          )),
    ])));
  }
}
