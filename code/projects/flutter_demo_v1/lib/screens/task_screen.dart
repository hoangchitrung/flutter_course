import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/categories.dart';
import 'package:flutter_demo_v1/models/task.dart';
import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  bool _submitting = false;

  List<Categories> _categories = [];

  Future<List<Task>> loadTasks() async {
    Uri uri = Uri.parse("https://6943460b69b12460f3141dde.mockapi.io/tasks");
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception("Something errors");
    }
  }

  Future<bool> deleteTask(Task task) async {
    Uri uri = Uri.parse("https://6943460b69b12460f3141dde.mockapi.io/tasks/id");
    final res = await http.delete(uri);
    return res.statusCode == 200;
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

  void delete(Task t) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure to delete this task?"),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final res = await deleteTask(t);
                if (res == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Delete task successful!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Delete task failed!")),
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Priority _selectedPriority = Priority.low; // Display the selected values
  String? _selectedCategory;
  // load categories
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

  // @override
  // void initState() {
  //   super.initState();
  //   loadCategories().then((data) {
  //     // Call api when init
  //     setState(() {
  //       _categories = data;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Column(
        children: [
          Column(
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: add,
                child: _submitting
                    ? const CircularProgressIndicator()
                    : Text("Add Task"),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: loadTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (!snapshot.hasData) {
                  return Center(child: Text("No Tasks"));
                }
                final tasks = snapshot.data!;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task t = tasks[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text(t.id.toString())),
                      title: Text(t.subject),
                      subtitle: Text(t.content),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.close, color: Colors.red),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
