import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var divwidth = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.navigate_before_rounded),
          ),
          Container(
            width: divwidth*0.8,
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20, color: Colors.black, ),
            ),
          ),
        ],
      ),
    );
  }
}
