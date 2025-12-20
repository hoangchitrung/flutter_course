import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/screens/task_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Task Management Screen"),
          backgroundColor: Colors.blue[400],
          centerTitle: true,
        ),
        body: const TaskScreen(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lightGreen,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'person'),
          ],
        ),
      ),
    );
  }
}
