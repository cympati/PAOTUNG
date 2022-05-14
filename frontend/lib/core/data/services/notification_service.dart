import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/notification/noti_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification/notification.dart';
import 'package:dio/dio.dart';

class GetNotification {
  static Future<List<dynamic>> getData() async {
    Response response = await Dio()
        .get('https://wwwii.bsthun.com/mock/paotung/show_notification.json');
    return response.data;
  }

  static List<Notifications> getNotification(data) {
    List list = data;
    List<Notifications> tempNotification = list
        .map((notification) => Notifications.fromJson(notification))
        .toList();
    return tempNotification;
  }

  static Future<dynamic> addCategory(String name, String date_time) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post("path", data: {
        "name": name,
        "date_time": date_time,
      });
      AddNotiResponse res = AddNotiResponse.fromJson (response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }
}
