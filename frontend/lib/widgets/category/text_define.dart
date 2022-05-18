import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/services/category_service.dart';
import 'package:paotung_frontend/screens/main/profile/category_setting.dart';

import '../../core/data/services/notification_service.dart';
import '../../screens/main/profile/notification_setting.dart';

class TextDefine extends StatelessWidget {
  final String text;
  final String buttonText;
  final bool isNotification;
  final String transactionType;
  final Function readJson;
  const TextDefine(
      {Key? key,required this.transactionType, required this.text, required this.buttonText, required this.isNotification, required this.readJson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 40, right: 40),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 16,color: AppColors.mainColor),
          ),
          const Spacer(),
          FlatButton(
              child: Text(buttonText, style:  TextStyle(fontSize: 14, color: AppColors.grey),),
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
                              if(isNotification && transactionType == "") {
                                await GetNotification.deleteAll();
                              } else {
                                if(transactionType == 'expense') {
                                  await CategoryService.deleteExpenseAll();
                                } else {
                                  await CategoryService.deleteIncomeAll();
                                }
                              }
                              readJson();
                              Navigator.of(context, rootNavigator: true).pop();
                      },
                          ),
                          // print("delete this category")
                        ],
                      );
                    });
              }),
        ],
      ),
    );
  }
}
