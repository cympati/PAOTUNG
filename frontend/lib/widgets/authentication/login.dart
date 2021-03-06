import 'package:flutter/material.dart';

class AuthenTitle extends StatefulWidget {
  final String title;
  final String description;
  const AuthenTitle({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  State<AuthenTitle> createState() => _AuthenTitleState();
}

class _AuthenTitleState extends State<AuthenTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 40, left: 40, top: 5),
          child: Text(
            widget.description,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
