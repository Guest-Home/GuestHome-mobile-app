import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/color/color.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right titles
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right titles
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 20,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ); // Display percentage on Y-axis
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 15,
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} jan',
                  style: Theme.of(context).textTheme.bodySmall,
                ); // Display day of the month on X-axis
              },
            ),
          ),
        ),

        borderData: FlBorderData(
          show: false,
        ),
        minX: 1, // January 1st
        maxX: 30, // January 31st
        minY: 0, // 0%
        maxY: 100, // 100%

        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(1, 10), // January 1: 10%
              FlSpot(7, 20), // January 7: 20%
              FlSpot(14, 15), // January 14: 15%
              FlSpot(21, 25), // January 21: 25%
              FlSpot(28, 30), // January 28: 30%
              FlSpot(31, 40), // January 31: 40%
            ],
            isCurved: true,
            dotData: FlDotData(
              show: true,
            ),
            gradient: LinearGradient(tileMode: TileMode.clamp, colors: [
              ColorConstant.primaryColor,
              ColorConstant.primaryColor
            ]),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}
