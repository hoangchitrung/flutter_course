import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseListState();
  }
}

class _ExpenseListState extends State<ExpenseListScreen> {
  Future<List<Item>> loadItem() async {
    try {
      Uri uri = Uri.parse(
        "https://694f24618531714d9bcd6564.mockapi.io/expense",
      );

      final res = await http.get(uri);

      if (res.statusCode == 200) {
        List data = json.decode(res.body);
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw Exception("Some thing gone wrong");
      }
    } catch (e) {
      throw Exception("Error when loading items: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense List")),
      body: FutureBuilder<List<Item>>(
        future: loadItem(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error at snapshot when loading item list: ${snapshot.error.toString()}",
              ),
            );
          }
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(leading: Text(item.id!));
            },
          );
        },
      ),
    );
  }
}
