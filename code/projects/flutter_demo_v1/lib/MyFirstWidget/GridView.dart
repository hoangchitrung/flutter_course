import 'package:flutter/material.dart';
import 'dart:math';

class GridViewMethod extends StatefulWidget {
  const GridViewMethod({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GridViewMethod();
  }
}

class _GridViewMethod extends State<GridViewMethod> {
  static Random random = Random();

  void update() {
    setState(() {
      colors.add(
        Container(
          width: 100,
          height: 200,
          color: Color.fromARGB(
            255,
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
          ),
        ),
      );
    });
  }

  List<Widget> colors = List.generate(5, (index) {
    return Container(
      width: 100,
      height: 200,
      color: Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      ),
    );
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
              Widget c = colors[index];
              return GridTile(child: c);
            },
          ),
        ),
        ElevatedButton(onPressed: update, child: Text("Add Color")),
      ],
    );
  }
}
