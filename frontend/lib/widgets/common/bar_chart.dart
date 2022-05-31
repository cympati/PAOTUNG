import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class BarChartTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartTwoState();
}

class BarChartTwoState extends State<BarChartTwo> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 8;

  final List<List<double>> weeklyData = [
    [5, 12],
    [16, 12],
    [18, 5],
    [20, 16],
    [17, 6],
    [19, 1.5],
    [10, 1.5]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: AppColors.lightgrey,
      ),
      margin: EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text(
            'Apr 11-17',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BarChart(
                _mainBarData(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartData _mainBarData() {
    return BarChartData(
      maxY: 20,
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'Mn';
            case 1:
              return 'Te';
            case 2:
              return 'Wd';
            case 3:
              return 'Tu';
            case 4:
              return 'Fr';
            case 5:
              return 'St';
            case 6:
              return 'Sn';
            default:
              return '';
          }
        },
      ),
    );
  }

  // Function to draw all the bars.
  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      weeklyData.length,
      (index) => _buildBar(index, weeklyData[index][0], weeklyData[index][1]),
    );
  }

  // Function to define how to bar would look like.
  BarChartGroupData _buildBar(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 5,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1,
          width: width,
        ),
        BarChartRodData(
          y: y2,
          width: width,
        ),
      ],
    );
  }
}