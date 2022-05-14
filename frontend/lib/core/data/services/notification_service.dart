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
    print(response.data);
    return NotificationResponse.fromJson(response.data).data;
  }

  // static List<Notifications> getNotification(data) {
  //   List list = data;
  //   List<Notifications> tempNotification = list.map((notification) => Notifications.fromJson(notification)).toList();
  //   return tempNotification;
  // }
}