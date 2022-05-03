import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/main/profile/new_notification.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/custom_app_bar.dart';
import 'package:paotung_frontend/widgets/common/notification.dart';

import '../../../constants/theme.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({ Key? key }) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "Notification Setting"),
      body: Column(
        children: [
          TextDefine(categotyText: "All Notifications", buttonText: "Clear All"),
          NotificationTitle(title: "Electric Bill"),
          NotificationTitle(title: "Saving 5 THB"),
          NotificationTitle(title: "Don't forget to record!"),
          
        ],
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NewNotification()));
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}