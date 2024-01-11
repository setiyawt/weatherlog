import 'package:flutter/material.dart';
import 'package:security_system/ui/home.dart';

class faq extends StatelessWidget {
  const faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('FAQ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is the Weather Log Campus Application?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The Weather Log Campus Application is a mobile application designed to monitor and display real-time temperature and humidity data on campus. Additionally, it allows users to make notes or logs based on weather conditions, especially during rain or other significant weather events.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How does the application detect rain or significant weather changes?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The application uses real-time weather data to detect changes in weather conditions, including rain. It relies on reliable sources to provide accurate information for timely updates.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Can I view historical temperature and humidity data for the campus?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Yes, the application offers a feature to view historical data, allowing users to analyze temperature and humidity patterns over time.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
              child: Container(
                width: 700,
                height: 250,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How does the note-taking feature work?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "The note-taking feature allows users to add personalized notes or memos related to specific weather conditions. This feature enhances preparedness and planning based on past weather experiences.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3259),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
