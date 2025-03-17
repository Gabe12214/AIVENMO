import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoChart extends StatelessWidget {
  final List<double> prices;

  CryptoChart({required this.prices});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots:
                prices
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
            isCurved: true,
            colors: [Colors.blue],
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
