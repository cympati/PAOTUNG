import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/my_custom_expansion_tile.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';
import '../../constants/theme.dart';
import '../../widgets/common/backward_app_bar.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 20,
              ),
              const BackwardAppbar(title: "Help Center"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                height: 100,
                alignment: Alignment.centerLeft,
                child: Text(
                  "FAQ",
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Theme(
                  data: ThemeData(
                      unselectedWidgetColor: AppColors.mainColor,
                      primarySwatch: Colors.grey,
                      dividerColor: Colors.transparent),
                  child: const MyCustomeExpandTile(
                      question: "What’s PAOTUNG?",
                      answer:
                          "Go to Profile page > Category Setting > Add Button")),
              Theme(
                  data: ThemeData(
                      unselectedWidgetColor: AppColors.mainColor,
                      primarySwatch: Colors.grey,
                      dividerColor: Colors.transparent),
                  child: const MyCustomeExpandTile(
                      question: "How to add more categories?",
                      answer:
                          "Go to Profile page > Category Setting > Add Button")),
              Theme(
                  data: ThemeData(
                      unselectedWidgetColor: AppColors.mainColor,
                      primarySwatch: Colors.grey,
                      dividerColor: Colors.transparent),
                  child: const MyCustomeExpandTile(
                      question: "How Notifications work?",
                      answer:
                          "Go to Profile page > Category Setting > Add Button")),
            ],
          ),
        ],
      ),
    );
  }
}
