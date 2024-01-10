import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailSuhu extends StatefulWidget {
  const DetailSuhu({Key? key}) : super(key: key);

  @override
  State<DetailSuhu> createState() => _DetailSuhuState();
}

class _DetailSuhuState extends State<DetailSuhu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Firestore Example',
            style: TextStyle(
              color: const Color.fromARGB(255, 248, 99, 99),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF1C2321),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Display data here
                var document = snapshot.data;

                // Check if document is not null before accessing its fields
                if (document != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Temp_c: ${document['temp_c']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Humidity: ${document['humidity']}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('Document not found');
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<DocumentSnapshot?> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('data-sensor')
        .orderBy('localtime', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Latest document found, return the first document
      return querySnapshot.docs.first;
    } else {
      // No documents in the collection
      return null;
    }
  }
}
