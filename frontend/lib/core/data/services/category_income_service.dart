import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryIncomeService {
  static Future<List<Categories>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
  dio.options.headers["Authorization"] = "Bearer " +  (token ?? " ");
  Response response = await dio.get(apiEndPoint + '/category/income');
  // print(response.data);
    return CategoryResponse.fromJson(response.data).data;
  }

  // static List<Categories> getCategories(data) {
  //   List list = data;
  //   List<Categories> tempCategoriesIncome = list.map((category) => Categories.fromJson(category)).toList();
  //   return tempCategoriesIncome;
  // }
}
