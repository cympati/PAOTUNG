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
}
