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

  Future<void> loadBooks() async {
    final res = await rootBundle.loadString("assets/data/books.json");
    final List<dynamic> data = json.decode(res);

    books = data.map((item) {
      return Book.fromJson(item);
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Books")),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            leading: Column(
              children: [Image.asset(book.image, width: 50, height: 50)],
            ),
            title: Container(
              child: Column(
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
                      Row(children: [Text(book.category)]),
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
              // trailing: null,
            ),
          );
        },
      ),
    );
  }
}
