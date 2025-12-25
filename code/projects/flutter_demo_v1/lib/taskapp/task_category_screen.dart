import 'package:flutter/material.dart';

class TaskCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskCategoryState();
  }
}

class _TaskCategoryState extends State<TaskCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Category")),
      body: Center(
        child: Text(
          "Task Category",
          style: TextStyle(fontSize: 40, color: Colors.grey),
        ),
      ),
    );
  }
}
