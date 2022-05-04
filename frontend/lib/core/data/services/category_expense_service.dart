import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryExpenseService {
  static Future<Map<String, dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/expense.json');
    return response.data;
  }

  static List<Categories> getCategoriesExpense(data) {
    List<dynamic> categoriesExpenseData = data["categories_expense"];
    List<Categories> tempCategoriesExpense = categoriesExpenseData.map((category) {
      return Categories(
        id: category["id"],
        name: category["name"],
        color: category["color"],
      );
    }).toList();
    return tempCategoriesExpense;
  }
}
