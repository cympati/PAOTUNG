// import 'dart:js';

import 'package:calendar_time/calendar_time.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/notification/noti_response.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/services/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/parse_date_time.dart';
import '../models/notification/notification.dart';
import 'package:dio/dio.dart';

import '../models/response/delete_reponse.dart';

class GetNotification {
  static Future<List<Notifications>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + "/notification/info");
    List<Notifications> res = NotificationResponse.fromJson(response.data).data;
    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        if(DateTime.parse(res[i].dateTime).isBefore(DateTime.now().add(const Duration(minutes: 15)))) {
          continue;
        }
        NotificationApi.showScheduledNotification(
          id: res[i].id,
          title: res[i].name,
          body: CalendarTime(parseDate(res[i].dateTime)).toHuman,
          scheduledDate: parseDate(res[i].dateTime).subtract(const Duration( minutes: 15)),
          // scheduledDate: DateTime.now().add(const Duration(seconds: 5))
        );
      }
    }
    return res;
  }

  static List<Notifications> getNotification(data) {
    List list = data;
    List<Notifications> tempNotification = list
        .map((notification) => Notifications.fromJson(notification))
        .toList();
    return tempNotification;
  }

  static Future<dynamic> deleteById(int notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.delete(
          apiEndPoint + "/notification/delete?notification_id=${notificationId}");
      DeleteResponse res = DeleteResponse.fromJson(response.data);
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


  static Future<dynamic> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.delete(
          apiEndPoint + "/notification/delete/all");
      DeleteResponse res = DeleteResponse.fromJson(response.data);
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
  // static Future<dynamic> addNotification(String name, String dateTime) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? userToken = prefs.getString('user');
  //   try {
  //     Response response = await Dio().post("path", data: {
  //       "name": name,
  //       "date_time": dateTime,
  //     });
  //     AddNotiResponse res = AddNotiResponse.fromJson(response.data);
  //     if (res.success) {
  //       return res;
  //     } else if (response is ErrorResponse) {
  //       var error = SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         margin: const EdgeInsets.only(left: 15, right: 15),
  //         content: Text(res.message),
  //         action: SnackBarAction(
  //           label: 'OK',
  //           onPressed: () {},
  //         ),
  //       );
  //       // ScaffoldMessenger.of(context).showSnackBar(error);
  //     }
  //
  //   } on DioError catch (e) {
  //     if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
  //       ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
  //       return error;
  //     }
  //   }
  //   return "";
  // }
}
