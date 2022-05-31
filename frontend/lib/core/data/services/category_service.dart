

import 'package:dio/dio.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/response/delete_reponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static Future<dynamic> deleteById(int categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.delete(
          apiEndPoint +
              "/category/delete?category_id=${categoryId}");
      DeleteResponse res = DeleteResponse.fromJson(response.data);
        return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }


  static Future<dynamic> deleteExpenseAll() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.delete(
          apiEndPoint + "/category/expense/delete/all");
      DeleteResponse res = DeleteResponse.fromJson(response.data);
        return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }


  static Future<dynamic> deleteIncomeAll() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.delete(
          apiEndPoint + "/category/income/delete/all");
      DeleteResponse res = DeleteResponse.fromJson(response.data);
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