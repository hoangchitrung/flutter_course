import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_v1/models/Book.dart';

class BookListDemo extends StatefulWidget {
  const BookListDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BookListDemoState();
  }
}

class _BookListDemoState extends State<BookListDemo> {
  List<Book> books = [];
  List<Book> searchBook = [];
  List<Book> result = [];

  final categories = {'Basic': false, 'Advanced': false};

  String filterQuery = "";
  String query = "";
  late bool checkboxStatus;
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
      searchBook = books;
    } catch (e) {
      print("Error while loading: $e");
    }
  }

  void applyFilters() {
    setState(() {
      // select categories
      final selectedCategories = categories.entries
          .where((e) => e.value == true) // take entry value as true
          .map((e) => e.key) // extract category name
          .toList();

      // search book by name
      if (query.isNotEmpty) {
        searchBook = books
            .where(
              (book) => book.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      } else {
        searchBook = books;
      }
      // filters book categories
      // if there is no search
      if (filterQuery.isNotEmpty) {
        result = books
            .where(
              (book) => book.category.toLowerCase().contains(
                filterQuery.toLowerCase(),
              ),
            )
            .toList();
        searchBook = result;
      }
      // When uncheck it will return the original list of books
      if (checkboxStatus == false) {
        searchBook = books;
      }
      // if (selectedCategories.isNotEmpty) {
      //   result = searchBook
      //       .where(
      //         (book) => book.category.toLowerCase().contains(
      //           selectedCategories.toString().toLowerCase(),
      //         ),
      //       )
      //       .toList();
      // }
    });
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
              // Search bar
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onChanged: (value) {
                query = value;
                applyFilters();
              },
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Filters", style: TextStyle(fontSize: 20)),
            ),
          ),

          Row(
            children: [
              ...categories.entries.map((e) {
                return Row(
                  children: [
                    Checkbox(
                      value: e.value,
                      onChanged: (value) {
                        setState(() {
                          categories[e.key] = value!;
                          filterQuery = e.key;
                          checkboxStatus = value;
                          applyFilters();
                        });
                      },
                    ),
                    Text(e.key),
                  ],
                );
              }).toList(),
            ],
          ),

          SizedBox(height: 10),

          Expanded(
            // Showing book card
            child: ListView.builder(
              itemCount: searchBook.length,
              itemBuilder: (context, index) {
                final book = searchBook[index];
                return BookCard(book: book);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Create a class for designing the book card
class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        book.price.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Icon(Icons.currency_pound),
                    ],
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
  }
}
