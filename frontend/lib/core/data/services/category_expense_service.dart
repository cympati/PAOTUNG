import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryExpenseService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/expense.json');
    return response.data;
  }

  static List<Categories> getCategories(data) {
    List list = data;
    List<Categories> tempCategoriesExpense = list.map((category) => Categories.fromJson(category)).toList();
    return tempCategoriesExpense;
  }
}
