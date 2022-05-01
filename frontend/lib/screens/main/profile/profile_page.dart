import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/start/login/login.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/widgets/common/list_item.dart';
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
            Container(
              height: 100,
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile",
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            //User pic & username
            profileSection(),
            SizedBox(
              height: 60,
            ),
            //list
            listItem(title: "Category Setting", routes: MainPage()),
            listItem(title: "Notification Setting", routes: MainPage()),
            listItem(title: "Help Center", routes: MainPage()),
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
