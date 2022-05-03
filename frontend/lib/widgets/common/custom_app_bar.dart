import 'package:flutter/material.dart';

class CloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CloseAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
