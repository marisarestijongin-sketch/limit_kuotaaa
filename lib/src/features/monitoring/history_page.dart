import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limit_kuota/src/core/data/database_helper.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> _historyList;

  @override
  void initState() {
    super.initState();
    _refreshHistory();
  }

  void _refreshHistory() {
    _historyList = DatabaseHelper.instance.getHistory();
  }

  // 🔧 format bytes
  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0.00 MB";
    double mb = bytes / (1024 * 1024);
    if (mb > 1024) {
      return "${(mb / 1024).toStringAsFixed(2)} GB";
    }
    return "${mb.toStringAsFixed(2)} MB";
  }

  // 📅 format tanggal biar cantik
  String _formatDate(String date) {
    DateTime parsed = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Riwayat Penggunaan"),
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _historyList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada riwayat data 😢"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📅 Tanggal
                    Text(
                      _formatDate(item['date']),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 📶 WiFi
                    Row(
                      children: [
                        const Icon(Icons.wifi, color: Colors.purple),
                        const SizedBox(width: 10),
                        Text("WiFi: ${_formatBytes(item['wifi'])}"),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // 📱 Data
                    Row(
                      children: [
                        const Icon(Icons.signal_cellular_alt,
                            color: Colors.pink),
                        const SizedBox(width: 10),
                        Text("Data: ${_formatBytes(item['mobile'])}"),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}