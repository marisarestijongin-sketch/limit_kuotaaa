import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  final List<Map<String, dynamic>> data = const [
    {"date": "2026-04-15", "wifi": 500, "mobile": 200},
    {"date": "2026-04-14", "wifi": 300, "mobile": 400},
    {"date": "2026-04-13", "wifi": 700, "mobile": 150},
  ];

  String formatBytes(int mb) {
    if (mb > 1024) return "${(mb / 1024).toStringAsFixed(2)} GB";
    return "$mb MB";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['date'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("WiFi: ${formatBytes(item['wifi'])}"),
                Text("Data: ${formatBytes(item['mobile'])}"),
              ],
            ),
          );
        },
      ),
    );
  }
}