import 'package:flutter/material.dart';

import 'custom_expansion_tile.dart';

class MyCustomeExpandTile extends StatefulWidget {
  const MyCustomeExpandTile({Key? key}) : super(key: key);

  @override
  State createState() => MyCustomeExpandTileState();
}

class MyCustomeExpandTileState extends State<MyCustomeExpandTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "What is PAOTUNG?",
          style: TextStyle(
              color: isExpanded ? const Color(0xFF22B07E) : Colors.black,
              fontSize: 16),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 249, 241),
      children: const <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
          title: Text(
            'Go to Profile page > Category Setting > Add Button',
            style: TextStyle(fontSize: 14),
          ),
        )
      ],
      onExpansionChanged: (bool expanding) =>
          setState(() => isExpanded = expanding),
    );
  }
}
