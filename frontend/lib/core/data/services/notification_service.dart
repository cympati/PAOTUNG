import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/notification/noti_response.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification/notification.dart';
import 'package:dio/dio.dart';

class GetNotification {
  static Future<List<Notifications>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/notification/info');
    return NotificationResponse.fromJson(response.data).data;
  }

  static List<Notifications> getNotification(data) {
    List list = data;
    List<Notifications> tempNotification = list
        .map((notification) => Notifications.fromJson(notification))
        .toList();
    return tempNotification;
  }

  static Future<dynamic> addCategory(String name, String dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post("path", data: {
        "name": name,
        "date_time": dateTime,
      });
      AddNotiResponse res = AddNotiResponse.fromJson(response.data);
      if (res.success) {
        return res;
      } else if (response is ErrorResponse) {
        var error = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 15, right: 15),
          content: Text(res.message),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        // ScaffoldMessenger.of(context).showSnackBar(error);
      }

    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }
}
