import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/taskapp/task_category_screen.dart';
import 'package:flutter_demo_v1/taskapp/task_list_screen.dart';

class TaskMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TaskMainState();
  }
}

class _TaskMainState extends State<TaskMainScreen> {
  List<Widget> screens = [TaskCategoryScreen(), TaskListScreen()];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task App")),
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 40), label: "Task List"),
          BottomNavigationBarItem(icon: Icon(Icons.task, size: 40), label: "Task Categories"),
        ],
      ),
    );
  }
}
