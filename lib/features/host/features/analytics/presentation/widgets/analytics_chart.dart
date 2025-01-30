import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/color/color.dart';

class AnalyticsChart extends StatelessWidget {
   const AnalyticsChart({
    super.key,
    required this.dailyOccupancy
  });

  final Map<String,double> dailyOccupancy;


   List<FlSpot> _prepareSpotsAndLabels(
       Map<String, double> data, Map<int, String> labels) {
     List<String> sortedDates = data.keys.toList()..sort();
     List<FlSpot> spots = [];
     for (int i = 0; i < sortedDates.length; i++) {
       String date = sortedDates[i];
       double value = data[date] ?? 0.0;

       // Add to spots
       spots.add(FlSpot(i + 1, value));

       // Add labels for specific intervals or the last point
       if (i % 10 == 0 || i == sortedDates.length - 1) {
         DateTime dateTime = DateTime.parse(date);
         labels[i + 1] = DateFormat('MMM d').format(dateTime); // e.g., "Dec 1"
       }
     }
     return spots;
   }
   String formatNumber(int number) {
     if (number >= 1000 && number < 1000000) {
       // Format for thousands
       return '${(number / 1000).toStringAsFixed(0)}k';
     } else if (number >= 1000000) {
       // Format for millions
       return '${(number / 1000000).toStringAsFixed(0)}M';
     }
     // Return as is if less than 1000
     return number.toString();
   }

   @override
  Widget build(BuildContext context) {
     Map<int, String> labels = {};
     List<FlSpot> spots = _prepareSpotsAndLabels(dailyOccupancy, labels);
     return LineChart(
       LineChartData(
         gridData: FlGridData(show: false),
         titlesData: FlTitlesData(
           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
           leftTitles: AxisTitles(
             sideTitles: SideTitles(
               reservedSize: 34,
               showTitles: true,
               interval: 25000,
               getTitlesWidget: (value, meta) => Text(formatNumber(value.toInt()),
                 style: Theme.of(context).textTheme.bodySmall,
               ),
             ),
           ),
           bottomTitles: AxisTitles(
             sideTitles: SideTitles(
               showTitles: true,
               interval:10, // Show labels for every 10th point
               getTitlesWidget: (value, meta) {
                 String? label = labels[value.toInt()];
                 if (label != null) {
                   return Text(
                     label,
                     style: Theme.of(context).textTheme.bodySmall,
                   );
                 }
                 return const Text('');
               },
             ),
           ),
         ),
         borderData: FlBorderData(show:false
         ),
         lineTouchData: LineTouchData(
           touchTooltipData: LineTouchTooltipData(
             tooltipPadding: const EdgeInsets.all(10), // Tooltip padding
           ),
         ),
         lineBarsData: [
           LineChartBarData(
             spots: spots,
             isCurved: true,
             dotData: FlDotData(show: true),
             belowBarData: BarAreaData(show: false),
             color:ColorConstant.primaryColor,

           ),
         ],
         minX: 1,
         maxX: spots.length.toDouble(),
         minY: 0,
         maxY: 100000,
         backgroundColor: ColorConstant.primaryColor.withValues(alpha: 0.02),
       ),
     );
  }
}
