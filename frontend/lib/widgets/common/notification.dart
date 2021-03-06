
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

import '../../core/data/services/notification_service.dart';
import '../../screens/main/profile/notification_setting.dart';

class NotificationTitle extends StatelessWidget {
  final String name;
  final int notificationId;
  final Function readJson;
  const NotificationTitle({Key? key, required this.name,required this.notificationId,required this.readJson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.lightgrey))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Are you sure you want to delete this",
                                style: TextStyle(fontSize: 18),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.mainColor),
                                  child: const Text("DELETE"),
                                  onPressed: () async {
                                    await GetNotification.deleteById(notificationId);
                                    readJson();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();

                            }
                                  ,
                                ),
                              ],
                            );
                          });
                    }),
              ],
            ),
          ),
        ));
  }
}
