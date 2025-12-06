import 'package:flutter/material.dart';

class Listcard extends StatelessWidget {
  var courses = [
    {
      'Language': 'C',
      'By': 'Dennis Ritchie',
      'icon': Icon(Icons.person, size: 30),
    },
    {
      'Language': 'Java',
      'By': 'James Gosling',
      'icon': Icon(Icons.person, size: 30),
    },
    {
      'Language': 'Python',
      'By': 'Guido van Rossum',
      'icon': Icon(Icons.person, size: 30),
    },
    {
      'Language': 'C++',
      'By': 'Bjarne Stroustrup',
      'icon': Icon(Icons.person, size: 30),
    },
    {
      'Language': 'JavaScript',
      'By': 'Brendan Eich',
      'icon': Icon(Icons.person, size: 30),
    },
  ];

  Listcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Courses"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            for (var course in courses) ... [
              Container(
                color: Colors.blueAccent,
                child: Row(
                  children: [
                    course['icon'] as Widget,
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          course['Language'] as String,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          course['By'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}
