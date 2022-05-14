import 'package:paotung_frontend/config/api.dart';

import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryIncomeService {
  static Future<List<dynamic>> getData() async {
    Response response =
        await Dio().get(apiEndPoint + '/category/income');
    return response.data;
  }

  static List<Categories> getCategories(data) {
    List list = data;
    List<Categories> tempCategoriesIncome =
        list.map((category) => Categories.fromJson(category)).toList();
    return tempCategoriesIncome;
  }
}
