import 'package:dio/dio.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUser{
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/profile/info');
    UserResponse userResponse = UserResponse.fromJson(response.data);
    return userResponse.data;
  }
}