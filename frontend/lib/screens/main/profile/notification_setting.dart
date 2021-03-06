import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/notification/notification.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/main/profile/new_notification.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';

import 'package:paotung_frontend/widgets/common/default_text.dart';
import 'package:paotung_frontend/widgets/common/notification.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/theme.dart';
import '../../../core/data/services/providers/providers.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  List<Notifications> _notification = [];

  @override
  void initState() {
    super.initState();
    _readJson();
    NotificationApi.init();
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
          children: [
            TextDefine(
              text: "All Notifications",
              buttonText: "Clear All",
              isNotification: true,
              readJson: _readJson,
              transactionType: "",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _notification.isEmpty
                  ? const DefaultText(text: 'notification', color: true)
                  : Column(
                      children: [

                        ..._notification.map((notification) {
                          return NotificationTitle(
                              name: notification.name,
                              notificationId: notification.id,
                              readJson: _readJson);
                        }).toList(),
                      ],
                    ),
            )
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  NewNotification(readJson:_readJson)));
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
