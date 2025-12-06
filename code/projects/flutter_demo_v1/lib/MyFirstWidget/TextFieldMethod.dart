import 'package:flutter/material.dart';

class TextFieldMethod extends StatefulWidget {
  const TextFieldMethod({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldMethodState();
  }
}

class _TextFieldMethodState extends State<TextFieldMethod> {
  final TextEditingController _controller = TextEditingController();
  String name = "";
  var selected = 'Dollar';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: selected,
          items: ['Dollar', 'VNĐ'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            setState(() => selected = value!);
          },
        ),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            label: Text("Input Your Name"),
            hint: Text("name"),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
        ),
        Text(
          "Welcome $name",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
      ],
    );
  }
}
