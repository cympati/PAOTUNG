import 'dart:developer';

import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryExpenseService {
  static Future<List<Categories>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
  dio.options.headers["Authorization"] = "Bearer " +  (token ?? " ");
  Response response = await dio.get(apiEndPoint + '/category/all');
  // print(CategoryResponse.fromJson(response.data).data.expenseList);
    return CategoryResponse.fromJson(response.data).data.expenseList;
  }

}
