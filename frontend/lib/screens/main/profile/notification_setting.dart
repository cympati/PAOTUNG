import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/notification/notification.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/main/profile/new_notification.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';

import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';
import 'package:paotung_frontend/widgets/common/notification.dart';

import '../../../constants/theme.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  List<Notifications> _notification = [];

  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseNotification = await GetNotification.getData();
    if (mounted) {
      setState(() {
        _notification = responseNotification;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackwardAppBar(title: "Notification Setting"),
      body: ListView(
          // padding: const EdgeInsets.symmetric(
          //   vertical: 15,
          //   horizontal: 40,
          // ),
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: _notification.isEmpty
                  ? DefaultText(text: 'notifiction')
                  : Column(
                      children: [
                        TextDefine(
                            categotyText: "All Notifications",
                            buttonText: "Clear All"),
                        ..._notification.map((notification) {
                          return NotificationTitle(name: notification.name);
                        }).toList(),
                        // NotificationTitle(name: "Electric Bill"),
                        // NotificationTitle(name: "Saving 5 THB"),
                        // NotificationTitle(name: "Don't forget to record!"),
                      ],
                    ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NewNotification()));
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
