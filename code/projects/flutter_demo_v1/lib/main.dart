import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/MyFirstWidget/Counter.dart';
import 'package:flutter_demo_v1/MyFirstWidget/GridView.dart';
import 'package:flutter_demo_v1/MyFirstWidget/ListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Demo App"),
          backgroundColor: Colors.blue[400],
          centerTitle: true,
        ),
        body: GridViewMethod(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          ],
        ),
      ),
    );
  }
}
