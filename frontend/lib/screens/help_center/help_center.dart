import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/help_center/faq.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/my_custom_expansion_tile.dart';
import '../../constants/theme.dart';
import '../../widgets/common/backward_app_bar.dart';
import '../main/profile/profile_page.dart';

class HelpCenter extends StatelessWidget {
  HelpCenter({Key? key}) : super(key: key);

  final List<Faq> _faq = [
    Faq(question: 'What is PAOTUNG?', answer: 'PAOTUNG is a The money tracking application that can help you manage your expenses and income in your daily life.'),
    Faq(question: 'How to add more categories?', answer: 'Go to Profile page > Category Setting > Add Button'),
    Faq(question: 'How Notifications work?', answer: 'Get&Set notification reminding you to record your daily transactions or the important events'),
    Faq(question: 'How to set notification?', answer: 'Go to Profile page > Notification Setting > Add Button'),
    Faq(question: 'PAOTUNG suggestion', answer: 'Keep recording your transaction everyday, so PAOTUNG can help you manage your finance effectivly'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              const BackwardAppBar(title: "Help Center",),
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
              ..._faq.map((e) {
                return Theme(
                    data: ThemeData(
                        unselectedWidgetColor: AppColors.mainColor,
                        primarySwatch: Colors.grey,
                        dividerColor: Colors.transparent),
                    child: MyCustomeExpandTile(
                        question: e.question, answer: e.answer));
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
