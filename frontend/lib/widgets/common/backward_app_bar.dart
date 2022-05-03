import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class BackwardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BackwardAppBar({Key? key, required this.title}) : super(key: key);

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
      leading: new IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        icon: Icon(
          Icons.navigate_before_rounded,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
