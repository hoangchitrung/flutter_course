import 'package:flutter/material.dart';

class MyHome2 extends StatelessWidget {
  const MyHome2({super.key});

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
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    color: Colors.purple,
                    child: Center(
                      child: Text(
                        "02.01",
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
                  child: Container(
                    color: Colors.lightBlue,
                    child: Center(
                      child: Text(
                        "02.02",
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
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.blueAccent,
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
