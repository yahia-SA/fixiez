import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({
    super.key,
    this.spots = const [
      FlSpot(0, 1),
      FlSpot(1, 3),
      FlSpot(2, 2),
      FlSpot(3, 4),
      FlSpot(4, 3),
      FlSpot(5, 5),
      FlSpot(6, 4),
    ],
    this.lineColor = AppColors.yellow,
    this.barColor = const Color(0xffFDF2C3),
    this.barOpacity = 0.3,
    this.barWidth = 1,
    this.isCurved = true,
  });
  final List<FlSpot> spots;
  final Color lineColor;
  final Color barColor;
  final double barOpacity;
  final double barWidth;
  final bool isCurved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: isCurved,
              color: lineColor,
              barWidth: barWidth,
              belowBarData: BarAreaData(
                show: true,
                color: barColor.withValues(alpha: barOpacity),
              ),
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
