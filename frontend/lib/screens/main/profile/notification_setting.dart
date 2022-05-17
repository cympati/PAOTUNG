import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paotung_frontend/core/data/models/notification/notification.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/main/profile/new_notification.dart';
import 'package:paotung_frontend/screens/main/profile/profile_page.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';

import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';
import 'package:paotung_frontend/widgets/common/notification.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/theme.dart';
import '../../../core/data/services/providers/providers.dart';
import '../../../core/utils/life_cycle.dart';

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
    NotificationApi.init();

    WidgetsBinding.instance?.addObserver(
        LifecycleEventHandler(resumeCallBack: () async =>  _readJson(), suspendingCallBack: () async => {})
    );

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
                  ? DefaultText(text: 'notification',color:true)
                  : Column(
                      children: [
                        TextDefine(
                            text: "All Notifications",
                            buttonText: "Clear All", isNotification:true,readJson:_readJson, transactionType: "",),
                        ..._notification.map((notification) {
                          return NotificationTitle(name: notification.name,notificationId:notification.id,readJson:_readJson);
                        }).toList(),
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
