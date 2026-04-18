import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Network extends StatelessWidget {
  const Network({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Grafik"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("WiFi",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 200, child: LineChart(_wifiChart())),

            const SizedBox(height: 30),

            const Text("Data",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 200, child: LineChart(_mobileChart())),
          ],
        ),
      ),
    );
  }

  LineChartData _wifiChart() {
    return LineChartData(
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: true),
      titlesData: _titles(),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 6),
            FlSpot(2, 4),
            FlSpot(3, 7),
          ],
          isCurved: true,
          color: Colors.purple,
        ),
      ],
    );
  }

  LineChartData _mobileChart() {
    return LineChartData(
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: true),
      titlesData: _titles(),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 4),
            FlSpot(3, 1),
          ],
          isCurved: true,
          color: Colors.pink,
        ),
      ],
    );
  }

  FlTitlesData _titles() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true),
      ),
    );
  }
}