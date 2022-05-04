import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/help_center/help_center.dart';
import 'package:paotung_frontend/screens/main/profile/category_setting.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/screens/start/login/login.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/widgets/common/list_item.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';
import 'package:paotung_frontend/widgets/main/profile/profile.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 40.0),
        child: Column(
          children: [
            //Title
            TextTitle(title: "Profile", size: 24),
            //User pic & username
            profileSection(),
            SizedBox(
              height: 55,
            ),
            //list
            listItem(title: "Category Setting", routes: CategorySetting()),
            listItem(
                title: "Notification Setting", routes: NotificationSetting()),
            listItem(title: "Help Center", routes: HelpCenter()),
            //Log out
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: AppColors.lightgrey))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("Log out",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
