import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  MyDataUploader().startUpload();
}

class MyDataUploader {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  late Timer _timer;

  final CollectionReference _firestoreCollection =
      FirebaseFirestore.instance.collection('data-sensor');

  void startUpload() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      uploadDataFromApi();
    });
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    const apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=bbd6da70ccf34f2b9f2132924241001&q=Bandung&q=6.8982,107.6358';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return List<Map<String, dynamic>>.from([jsonData]);
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> uploadDataFromApi() async {
    try {
      final List<Map<String, dynamic>> jsonData = await fetchData();

      for (var data in jsonData) {
        final double temp_c = data['current']['temp_c'].toDouble();
        final double humidity = data['current']['humidity'].toDouble();
        final String localtimeString = data['location']['localtime'];
        final DateTime localtime = DateTime.parse(localtimeString);
        final String formattedLocaltime =
            DateFormat("yyyy-MM-dd HH:mm:ss").format(localtime);

        final Map<String, dynamic> newData = {
          'temp_c': temp_c,
          'humidity': humidity,
          'localtime': formattedLocaltime,
        };

        DatabaseReference newChildReference = _database.push();
        await newChildReference.set(newData);

        await _firestoreCollection.add(newData);

        print('Data uploaded to Realtime Database and Firestore.');
      }

      print(
          'Temperature, humidity and localdatetime data uploaded to Firebase Realtime Database.');
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  void dispose() {
    _timer.cancel();
  }
}
