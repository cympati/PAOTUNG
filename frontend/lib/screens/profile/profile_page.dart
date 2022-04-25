import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/widgets/common/app_bar.dart';
import '../../widgets/common/list_item.dart';
import '../../widgets/main/profile/profile.dart';

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
              profileSection(),
              SizedBox(height: 60,),
              listItem(title: "Category Setting", routes: MainPage()),
              listItem(title: "Notification Setting", routes: MainPage()),
              listItem(title: "Help Center", routes: MainPage()),
            ],
          ),
        ),
    );
  }
}
