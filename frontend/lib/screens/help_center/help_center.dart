import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/my_custom_expansion_tile.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';
import '../../constants/theme.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackwardAppBar(
        title: "Help Center",
      ),
      body: Column(
        children: <Widget>[
          BackwardAppbar(title: "Help Center"),
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 30.0),
            child: TextTitle(title: "FAQ", size: 32),
          ),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()),
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: AppColors.mainColor,
                  primarySwatch: Colors.grey,
                  dividerColor: Colors.transparent),
              child: const MyCustomeExpandTile()),
        ],
      ),
    );
  }
}
