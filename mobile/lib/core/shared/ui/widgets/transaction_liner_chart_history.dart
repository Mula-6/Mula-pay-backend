import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/constant/colors.dart';
import 'package:mobile/features/home/data/models/dummy_date_data.dart';

import '../../../constant/test_styles.dart';

class TransactionLinerChartHistory extends StatelessWidget {
  const TransactionLinerChartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.3,
        child: LineChart(
          LineChartData(
            maxY: 60,
            minX: 0,
            maxX: (DummyDateData.spots7Days.length - 1).toDouble(),
            minY: 0,
            //  maxY: (DummyDateData.spots7Days.length + 1)
            //       .toDouble(),
            lineBarsData: [
              LineChartBarData(
                // preventCurveOverShooting: true,
                gradient: KColors.primaryGradient,
                isCurved: true,
                curveSmoothness: 0.35,
                spots: DummyDateData.spots7Days,
                barWidth: 3,
                color: Theme.of(context).colorScheme.primary,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withAlphaOpacity(0.3),
                      Theme.of(
                        context,
                      ).colorScheme.secondary.withAlphaOpacity(0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(show: false),
              ),
            ],

            // REMOVE GRID (clean look)
            gridData: FlGridData(show: false),

            // REMOVE BORDER
            borderData: FlBorderData(show: false),

            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,

                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Center(
                      child: Text(
                        DummyDateData.dates7Days[value.toInt()],
                        style: KTextStyles.bodySmall(context),
                      ),
                    );
                  },
                ),
              ),
            ),

            clipData: FlClipData.all(),

            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (spots) {
                  return spots.map((spot) {
                    return LineTooltipItem(
                      "₦${spot.y.toStringAsFixed(2)}\n${DummyDateData.spots7Days[spot.x.toInt()]}",
                      const TextStyle(fontWeight: FontWeight.bold),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
