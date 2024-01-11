import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security_system/ui/history.dart';
import 'package:security_system/ui/managesensor.dart';
import 'package:security_system/ui/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = const [
    Icon(Icons.home, size: 25),
    Icon(Icons.settings_applications, size: 25),
    Icon(Icons.history, size: 25),
    Icon(Icons.people, size: 25),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    List<Widget> widgets = [
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bellefair',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Today's Detection",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 220,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1C2321),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 82, 81, 81)
                                    .withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: FutureBuilder(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                var document = snapshot.data;

                                if (document != null) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                              left: 30,
                                              right: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  (document?['temp_c'] ?? 0) <
                                                          30
                                                      ? Colors.red
                                                      : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${document['temp_c']}°C',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Temp',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 5),
                                            decoration: BoxDecoration(
                                              color:
                                                  (document?['humidity'] ?? 0) >
                                                          80
                                                      ? Colors.red
                                                      : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${document?['humidity'] ?? ''}%',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Humidity',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 260,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 20,
                                          bottom: 5,
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Status:',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  (document?['temp_c'] ?? 0) <
                                                              30 &&
                                                          (document?['humidity'] ??
                                                                  0) >
                                                              80
                                                      ? 'Rainy'
                                                      : 'Not Raining',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: (document?['temp_c'] ??
                                                                    0) <
                                                                30 &&
                                                            (document?['humidity'] ??
                                                                    0) >
                                                                80
                                                        ? Colors.red
                                                        : Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                    ),
                  ),
                  Container(
                    height: 170,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2321),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 82, 81, 81)
                                  .withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: Column(
                              // children: [
                              //   Expanded(
                              //     child: RealtimeChart(),
                              //   ),
                              // ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ManageSensor(),
      History(),
      Profile(),
    ];

    return Scaffold(
      backgroundColor: Color(0xFF5E6572),
      body: widgets[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF1C2321),
        items: items,
        index: index,
        onTap: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            index = selectedIndex;
            print(index);
          });
        },
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
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
