import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/MyFirstWidget/ListCard.dart';
import 'package:flutter_demo_v1/MyFirstWidget/MyHome2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "My Demo App", home: Listcard());
  }
}
