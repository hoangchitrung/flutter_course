import 'package:flutter/material.dart';

class Listcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Courses"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Container(color: Colors.lightBlue, child: Icon(Icons.person)),
                ],
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
