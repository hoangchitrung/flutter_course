import 'package:flutter/material.dart';

class DropDownListMethod extends StatefulWidget {
  const DropDownListMethod({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DropDownlistState();
  }
}

class _DropDownlistState extends State<DropDownListMethod> {
  String seleteced = "Dollar";

  final TextEditingController _currencyController1 = TextEditingController();
  final TextEditingController _currencyController2 = TextEditingController();

  int? inputCurrency;
  int? outputCurrency;

  int dollar = 26359;

  dynamic convertCurrency(int inputCurrency, int outputCurrency) {

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _currencyController1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Input currency"),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: DropdownButton<String>(
                  value: seleteced,
                  items: ['Dollar', 'VND', 'EUR']
                      .map((e) => DropdownMenuItem(value: e, child: Text((e))))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _currencyController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Input currency"),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: DropdownButton<String>(
                  value: seleteced,
                  items: ['Dollar', 'VND', 'EUR']
                      .map((e) => DropdownMenuItem(value: e, child: Text((e))))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: convertCurrency(inputCurrency!, outputCurrency!),
            child: Text("Convert", style: TextStyle(fontSize: 30)),
          ),
        ],
      ),
    );
  }
}
