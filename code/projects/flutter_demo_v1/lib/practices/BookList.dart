import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_v1/models/Book.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookListState();
  }
}

class _BookListState extends State<BookList> {
  List<Book> books = [];
  List<Book> filteredBook = [];

  String dataPath = "assets/data/books.json";
  Future<void> loadBooks() async {
    try {
      final res = await rootBundle.loadString(dataPath);
      final List<dynamic> data = json.decode(res);

      setState(() {
        books = data.map((item) {
          return Book.fromJson(item);
        }).toList();
      });
      filteredBook = books;
    } catch (e) {
      print("Error while loading: $e");
    }
  }

  void filterBook(String query) {
    if (query.isEmpty) {
      filteredBook = books;
    } else {
      filteredBook = books
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
    return Scaffold(
      appBar: AppBar(title: Text("Books List")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filterBook(value);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBook.length,
              itemBuilder: (context, index) {
                final book = filteredBook[index];
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(book.image, width: 50, height: 50),
                          Column(
                            children: [
                              Text(
                                book.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                book.price.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            book.category,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          book.active
                              ? Icon(Icons.check, color: Colors.green)
                              : Icon(Icons.cancel, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
