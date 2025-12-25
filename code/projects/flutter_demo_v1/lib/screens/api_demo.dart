import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/categories.dart';
import 'package:flutter_demo_v1/screens/task_screen.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  const ApiDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ApiDemoState();
  }
}

class _ApiDemoState extends State<ApiDemo> {
  bool isGrid = false; // List will be default

  Future<List<Categories>> loadCategories() async {
    Uri uri = Uri.parse(
      "https://6943460b69b12460f3141dde.mockapi.io/categories",
    );
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      List data = json.decode(res.body);
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception("Something errors");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Demo"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
            icon: Icon(isGrid == true ? Icons.grid_view : Icons.list),
          ),
        ],
      ),
      body: FutureBuilder<List<Categories>>(
        future: loadCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}"));
          }

          final categories = snapshot.data!;
          if (isGrid == false) {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final c = categories[index];
                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TaskScreen(cateId: c.id);
                          },
                        ),
                      );
                    },
                    child: CircleAvatar(child: Text(c.id)),
                  ),
                  title: Text(c.name),
                );
              },
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final c = categories[index];
                return Card(
                  child: Center(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return TaskScreen(cateId: c.id);
                                },
                              ),
                            );
                          },
                          child: CircleAvatar(
                            child: Text(c.id, style: TextStyle(fontSize: 20)),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(c.name, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
