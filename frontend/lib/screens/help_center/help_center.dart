import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/my_custom_expansion_tile.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';
import '../../constants/theme.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //Don't forget to add Appbar widgets that YOK have been created
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 30.0),
            child: TextTitle(title: "FAQ", size: 32),
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
