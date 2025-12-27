import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo_v1/models/item.dart';
import 'package:http/http.dart' as http;

class ExpenseTotalScreen extends StatefulWidget {
  const ExpenseTotalScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseTotalState();
  }
}

class _ExpenseTotalState extends State<ExpenseTotalScreen> {
  // Hàm load items từ API
  Future<List<Item>> loadItems() async {
    try {
      Uri uri = Uri.parse(
        "https://694f24618531714d9bcd6564.mockapi.io/expense",
      );

      final res = await http.get(uri);

      if (res.statusCode == 200) {
        List data = json.decode(res.body);
        return data.map((json) => Item.fromJson(json)).toList();
      } else {
        throw Exception("Error loading items");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Hàm tính tổng income
  double calculateTotalIncome(List<Item> items) {
    double total = 0;
    for (Item item in items) {
      if (item.type == ItemType.income) {
        total += item.amount;
      }
    }
    return total;
  }

  // Hàm tính tổng expense
  double calculateTotalExpense(List<Item> items) {
    double total = 0;
    for (Item item in items) {
      if (item.type == ItemType.expense) {
        total += item.amount;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total Expenses")),
      body: FutureBuilder<List<Item>>(
        future: loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data!;
          final totalIncome = calculateTotalIncome(items);
          final totalExpense = calculateTotalExpense(items);
          final balance = totalIncome - totalExpense;

          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Income Card
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "INCOME",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${totalIncome.toStringAsFixed(0)} VND",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Expense Card
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPENSE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${totalExpense.toStringAsFixed(0)} VND",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Balance Card
                Card(
                  color: Colors.blue[50],
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BALANCE",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${balance.toStringAsFixed(0)} VND",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
