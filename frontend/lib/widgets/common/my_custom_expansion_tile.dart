import 'package:flutter/material.dart';

import 'custom_expansion_tile.dart';

class MyCustomeExpandTile extends StatefulWidget {
  final String question;
  final String answer;
  const MyCustomeExpandTile({Key? key, required this.question,required this.answer}) : super(key: key);

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
          widget.question,
          style: TextStyle(
              color: isExpanded ? const Color(0xFF22B07E) : Colors.black,
              fontSize: 16),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 249, 241),
      children:  <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32.0),
          title: Text(
            widget.answer,
            style: const TextStyle(fontSize: 14),
          ),
        )
      ],
      onExpansionChanged: (bool expanding) =>
          setState(() => isExpanded = expanding),
    );
  }
}
