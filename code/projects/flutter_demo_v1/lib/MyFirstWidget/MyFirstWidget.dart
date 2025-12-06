import 'package:flutter/material.dart';

class Myfirstwidget extends StatelessWidget {
  const Myfirstwidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          "Hello World",
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
