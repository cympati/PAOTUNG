import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/screens/help_center/help_center.dart';
import 'package:paotung_frontend/screens/main/profile/category_setting.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/widgets/common/list_item.dart';
import 'package:paotung_frontend/widgets/common/text_title.dart';
import 'package:paotung_frontend/widgets/main/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late SharedPreferences prefs;
  User _user = User(imagePath: '', email: '', username: '', balance: 0);


  @override
  void initState() {
    super.initState();
    if (mounted) {
      _readJson();
    }
    //
  }
  deleteUserData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }


  Future<void> _readJson() async {
    var responseUser = await GetUser.getData();
    if (mounted) {
      setState(() {
        _user = responseUser;
      });
      print("my image");
      print(_user.imagePath);
    }

    // print(_user.email.toString());
    // print(_user.imagePath);
    // print(NetworkImage(nullUser.imagePath).url);
    // print(NetworkImage(nullUser.imagePath));
    // print(FileImage(File('/storage/emulated/0/Download/${_user.imagePath}'), scale: 1.0));
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
        child: Column(
          children: [
            //Title
            const TextTitle(title: "Profile", size: 24),
            //User pic & username
             profileSection(readJson: _readJson, user: _user,),
            const SizedBox(
              height: 35,
            ),
            //list
            const ListItem(title: "Category Setting", routes: CategorySetting()),
            const ListItem(
                title: "Notification Setting", routes: NotificationSetting()),
            ListItem(title: "Help Center", routes: HelpCenter()),
            //Log out
            InkWell(
              onTap: () {
                deleteUserData();
                Navigator.popAndPushNamed(context, '/login');
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
      ),]
    );
  }
}
