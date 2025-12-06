import 'package:flutter/material.dart';

class ListViewMethod extends StatefulWidget {
  const ListViewMethod({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListViewMethodState();
  }
}

class _ListViewMethodState extends State<ListViewMethod> {
  List<String> products = List.generate(5, (index) {
    return "MY PRODUCT $index";
  });

  void update() {
    setState(() {
      products.add("MY PRODUCT ${products.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                String p = products[index];
                return ListTile(
                  leading: Icon(Icons.person, size: 60),
                  title: Text(p),
                  trailing: Icon(Icons.arrow_forward),
                );
              },
            ),
          ),
          ElevatedButton(onPressed: update, child: Text("Add Product")),
        ],
      ),
    );
  }
}
