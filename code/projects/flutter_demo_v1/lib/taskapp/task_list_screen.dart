import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TasklistState();
  }
}

class _TasklistState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task List")),
      body: Center(
        child: Text(
          "Task List",
          style: TextStyle(fontSize: 40, color: Colors.grey),
        ),
      ),
    );
  }
}
