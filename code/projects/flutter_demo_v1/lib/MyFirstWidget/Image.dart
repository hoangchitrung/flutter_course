import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_v1/models/Book.dart';

class ImageMethod extends StatefulWidget {
  const ImageMethod({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ImageMethodState();
  }
}

class _ImageMethodState extends State<ImageMethod> {
  List<Book> books = [];
  List<Book> filteredBooks = [];

  Future<void> loadBooks() async {
    try {
      final res = await rootBundle.loadString("assets/data/books.json");
      final List<dynamic> data = json.decode(res);

      setState(() {
        books = data.map((item) {
          return Book.fromJson(item);
        }).toList();
        filteredBooks = books;
      });
    } catch (e) {
      print("Error while loading books: $e");
    }
  }

  void filterBook(String query) {
    if (query.isEmpty) {
      filteredBooks = books;
    } else {
      filteredBooks = books
          .where(
            (book) => book.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Books"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filterBook(value);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          final book = filteredBooks[index];
          return ListTile(
            leading: Image.asset(book.image, width: 50, height: 50),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(book.name, style: TextStyle(fontSize: 15)),
                          Text(
                            book.price.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Text(book.category),
                    Row(
                      children: [
                        book.active
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
