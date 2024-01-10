import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailGas extends StatefulWidget {
  const DetailGas({Key? key}) : super(key: key);

  @override
  _DetailGasState createState() => _DetailGasState();
}

class _DetailGasState extends State<DetailGas> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      CollectionReference dataCollection =
          FirebaseFirestore.instance.collection('7day-overview');

      QuerySnapshot dataQuerySnapshot = await dataCollection.get();

      setState(() {
        data = dataQuerySnapshot.docs
            .map((DocumentSnapshot document) =>
                Map<String, dynamic>.from(document.data() as Map))
            .toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chart Example',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF1C2321),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['Temp'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.blue, // Warna untuk data suhu
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['Gas'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.green, // Warna untuk data kelembaban
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['Flame'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.orange, // Warna untuk data kelembaban
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  for (int j = 0; j < data.length; j++)
                    FlSpot(
                      j.toDouble(),
                      data[j]['Motion'].toDouble(),
                    ),
                ],
                isCurved: true,
                color: Colors.pink, // Warna untuk data kelembaban
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
              ),
            ],
            // Konfigurasi lainnya seperti borderData, gridData, dan titlesData
          ),
        ),
      ),
    );
  }
}
