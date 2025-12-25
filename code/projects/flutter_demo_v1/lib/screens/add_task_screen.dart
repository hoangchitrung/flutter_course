import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/categories.dart';
import 'package:flutter_demo_v1/models/task.dart';
import 'package:http/http.dart' as http;

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddTaskScreenState();
  }
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  Priority _selectedPriority = Priority.low;
  String? _selectedCategory;

  bool _submitting = false;

  Future<List<Categories>> loadCategories() async {
    Uri uri = Uri.parse(
      "https://6943460b69b12460f3141dde.mockapi.io/categories",
    );

    final res = await http.get(uri);

    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception("Something error");
    }
  }

  Future<bool> addTask(Task task) async {
    Uri uri = Uri.parse("https://6943460b69b12460f3141dde.mockapi.io/tasks");
    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()), // Gửi là encode còn lấy về là decode
    );

    return res.statusCode == 201;
  }

  void add() async {
    setState(() => _submitting = true);

    try {
      Task t = Task(
        subject: _subjectController.text,
        content: _contentController.text,
        priority: _selectedPriority.name,
        categories: _selectedCategory!,
      );

      final res = await addTask(t);
      if (res == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Add task successful!")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Add task failed!")));
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task Screen")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              // Task Subject Input Field
              controller: _subjectController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                label: Text("Task Subject"),
                hint: Text("Enter Task Subject"),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              // Task Content Input Field
              controller: _contentController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                label: Text("Task Content"),
                hint: Text("Enter Task Content"),
              ),
            ),

            SizedBox(height: 20),

            DropdownButtonFormField<Priority>(
              initialValue: _selectedPriority,
              items: Priority.values.map((p) {
                // value p will return the selected value and mapping one by one
                return DropdownMenuItem(value: p, child: Text(p.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
            ),
            SizedBox(height: 20),
            FutureBuilder(
              // Using Future Builder
              future: loadCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final categories = snapshot.data!;
                return DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  hint: Text('Select a category'),
                  items: categories.map((c) {
                    return DropdownMenuItem(value: c.id, child: Text(c.name));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: add,
              child: _submitting
                  ? const CircularProgressIndicator()
                  : Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
