import 'package:flutter/material.dart';

class ExpenseTotalScreen extends StatefulWidget {
  const ExpenseTotalScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseTotalState();
  }
}

class _ExpenseTotalState extends State<ExpenseTotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Total Expenses")));
  }
}
