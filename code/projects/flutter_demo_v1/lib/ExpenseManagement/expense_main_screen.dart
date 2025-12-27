import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/ExpenseManagement/expense_add_screen.dart';
import 'package:flutter_demo_v1/ExpenseManagement/expense_list_screen.dart';
import 'package:flutter_demo_v1/ExpenseManagement/expense_total_screen.dart';

class ExpenseMainScreen extends StatefulWidget {
  const ExpenseMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<ExpenseMainScreen> {
  List<Widget> screens = [
    ExpenseListScreen(),
    ExpenseAddScreen(),
    ExpenseTotalScreen(),
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
        backgroundColor: Colors.blue[400],
      ),
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "List"),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: "Add",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "Total"),
        ],
      ),
    );
  }
}
