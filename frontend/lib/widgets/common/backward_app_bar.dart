import 'package:flutter/material.dart';


class BackwardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BackwardAppBar({Key? key, required this.title, }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 31),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(
            Icons.navigate_before_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(
                context)
                .pop();
          },
        ),) ,
    );
  }
}
