import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryExpenseService {
  static Future<dynamic> addCategoryService(
      String name, String transactionType, int selectedColor) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(apiEndPoint + '/category/add',
          data: {
            'name': name,
            'transaction_type': transactionType,
            'color': selectedColor,
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      CategoryResponse res = CategoryResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return null;
  }

  static Future<List<Categories>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/category/all');
    // print(CategoryResponse.fromJson(response.data).data.expenseList);
    return CategoryResponse.fromJson(response.data).data.expenseList;
  }
}
