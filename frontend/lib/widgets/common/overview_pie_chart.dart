import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import '../../core/data/models/category/piedata.dart';
import 'indicator.dart';

class OverviewPieChart extends StatefulWidget {
  const OverviewPieChart({
    Key? key,
    required this.piedata,
  }) : super(key: key);

  final List<PieData> piedata;

  @override
  State<StatefulWidget> createState() => OverviewPieChartState();
}

class OverviewPieChartState extends State<OverviewPieChart> {
  List<PieChartSectionData> getSection() => widget.piedata
      .asMap()
      .map<int, PieChartSectionData>((index, piedata) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 17 : 12;
        final double radius = isTouched ? 65 : 60;

        final value = PieChartSectionData(
          color: Color(piedata.color),
          value: piedata.percent ,
          title: '${piedata.percent.toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 240,
      child: Card(
        color: AppColors.lightgrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 180,
              child: PieChart(
                PieChartData(
                  startDegreeOffset: 10,
                    pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 18,
                    sections: getSection()),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicators(pieDatas: widget.piedata),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
