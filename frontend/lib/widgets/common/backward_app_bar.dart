import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class BackwardAppbar extends StatefulWidget {
  final String title;
  const BackwardAppbar({Key? key, required this.title}) : super(key: key);

  @override
  State<BackwardAppbar> createState() => _BackwardAppbarState();
}

class _BackwardAppbarState extends State<BackwardAppbar> {
  @override
  Widget build(BuildContext context) {
    var divwidth = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      child: Padding(
        padding: EdgeInsets.only(left: 30, top: 40, bottom: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Icon
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.navigate_before_rounded,
                size: 36,
              ),
            ),
            //Text
            Container(
              width: divwidth * 0.8,
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
