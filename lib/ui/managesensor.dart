import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageSensor extends StatelessWidget {
  const ManageSensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Record',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: FirestoreDataScreen(),
    );
  }
}

class FirestoreDataScreen extends StatefulWidget {
  @override
  _FirestoreDataScreenState createState() => _FirestoreDataScreenState();
}

class _FirestoreDataScreenState extends State<FirestoreDataScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var document = documents[index];
              var temp_c = document['temp_c'];
              var humidity = document['humidity'];
              var time = document['localtime'];

              return ListTile(
                title: Text('Temperature: $temp_c'),
                subtitle: Text('Humidity: $humidity\nTime: $time'),
              );
            },
          );
        }
      },
    );
  }

  Future<QuerySnapshot> fetchData() async {
    try {
      var collection = FirebaseFirestore.instance.collection("data-sensor");
      var querySnapshot =
          await collection.orderBy('localtime', descending: true).get();
      return querySnapshot;
    } catch (e) {
      throw e;
    }
  }
}
