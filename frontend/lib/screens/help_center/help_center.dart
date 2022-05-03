import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/my_custom_expansion_tile.dart';
import '../../constants/theme.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //Don't forget to add Appbar widgets that YOK have been created
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            height: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              "FAQ",
              style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()
          ),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()
          ),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()
          ),
        ],
      ),
    );
  }
}
