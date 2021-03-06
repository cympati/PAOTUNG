import 'package:flutter/material.dart';

class CloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CloseAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60,right: 9),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          title,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),

          )
        ],
      ),
    );
  }
}
