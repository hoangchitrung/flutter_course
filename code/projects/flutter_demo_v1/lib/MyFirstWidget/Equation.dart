import 'package:flutter/material.dart';

class Equation extends StatefulWidget {
  const Equation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EquationState();
  }
}

class _EquationState extends State<Equation> {
  final TextEditingController _a = TextEditingController();
  final TextEditingController _b = TextEditingController();
  int? a = 0;
  int? b = 0;

  dynamic equationCalc(int a, int b) {
    if (a == 0) {
      if (b == 0) {
        return "Many root";
      } else {
        return "No roots";
      }
    } else {
      return -b / a;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _a,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Input A"),
              hint: Text("A"),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                a = int.tryParse(value);
              });
            },
          ),
          SizedBox(height: 20),
          TextField(
            controller: _b,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Input B"),
              hint: Text("B"),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                b = int.tryParse(value);
              });
            },
          ),

          Text(
            a != null && b != null
                ? "Result: ${equationCalc(a!, b!)}"
                : "Please enter both A and B",
            style: TextStyle(fontSize: 30, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
