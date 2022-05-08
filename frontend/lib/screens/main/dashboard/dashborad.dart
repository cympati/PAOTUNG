import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/common/overview_pie_chart.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';

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
              const OverviewPieChart(),
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
              const OverviewPieChart(),
              const SizedBox(
                height: 40,
              ),
            ],
          )),
    ])));
  }
}
