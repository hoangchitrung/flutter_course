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

  final TextEditingController _textEditingController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final categories = {
    'Programming': false,
    'Data': false,
    'OS': false,
    'Software': false,
  };

  int page = 0;

  Future<void> loadBooks() async {
    try {
      final res = await rootBundle.loadString("assets/data/books$page.json");
      final List<dynamic> data = json.decode(res);

      setState(() {
        final newBooks = data.map((item) {
          return Book.fromJson(item);
        }).toList();
        books.addAll(newBooks); // append keep the old page as the list
      });
      searchBook = books;
    } catch (e) {
      print("Error while loading: $e");
    }
  }

  void applyFilters() {
    // Take text from controller instead of variable query
    String txt = _textEditingController.text;
    setState(() {
      // select categories
      final selectedCategories = categories.entries
          .where((e) => e.value == true) // take entry value as true
          .map((e) => e.key) // extract category name
          .toList();

      // Start from books
      List<Book> result = books;

      // Filter by text
      if (txt.isNotEmpty) {
        result = result
            .where(
              (book) => book.name.toLowerCase().contains(txt.toLowerCase()),
            )
            .toList();
      }

      // Filter by categories
      if (selectedCategories.isNotEmpty) {
        result = result
            .where((book) => selectedCategories.contains(book.category))
            .toList();
      }
      searchBook = result;
    });
  }

  @override
  void initState() {
    super.initState();
    loadBooks();

    _textEditingController.addListener(() {
      // Call func when text change
      applyFilters();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        if (page < 3) {
          loadBooks();
          print(page);
        }
      } else if (_scrollController.position.pixels ==
          _scrollController.position.minScrollExtent) {
        page -= 1;
        if (page > -1) {
          loadBooks();
          print(page);
        }
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose(); // release memory
    _scrollController.dispose();
    super.dispose();
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
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
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
              controller: _scrollController,
              itemCount: searchBook.length,
              itemBuilder: (context, index) {
                final book = searchBook[index];
                return Dismissible(
                  key: ValueKey(book.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    searchBook.remove(book);
                  },
                  child: BookCard(book: book),
                );
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
