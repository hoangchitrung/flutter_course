import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/item.dart';
import 'package:http/http.dart' as http;

class ExpenseAddScreen extends StatefulWidget {
  const ExpenseAddScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseAddState();
  }
}

class _ExpenseAddState extends State<ExpenseAddScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  ItemType _selectedType = ItemType.income;

  bool _submiting = false;

  Future<bool> addExpense(Item item) async {
    Uri uri = Uri.parse("https://694f24618531714d9bcd6564.mockapi.io/expense");

    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );
    return res.statusCode == 201;
  }

  void add() async {
    setState(() => _submiting = true);

    try {
      Item it = Item(
        content: _contentController.text,
        amount: double.tryParse(_amountController.text) ?? 0.0,
        type: _selectedType,
      );

      final res = await addExpense(it);
      if (res == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Add expense successful!")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to add expense")));
      }
    } catch (e) {
      throw Exception("Error while add more expense: $e");
    } finally {
      setState(() => _submiting = false);
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                label: Text("Enter your content here"),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                label: Text("Enter your amount here"),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<ItemType>(
              initialValue: _selectedType,
              decoration: InputDecoration(
                label: Text("Select Type"),
                border: OutlineInputBorder(),
              ),
              items: ItemType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: add,
              child: _submiting
                  ? const CircularProgressIndicator()
                  : Text("Add Expense", style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
