import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.red,
            child: Center(
              child: Text(
                "01",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text(
                "02",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                "03",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
