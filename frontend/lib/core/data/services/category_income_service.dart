import '../models/category/categories.dart';
import 'package:dio/dio.dart';

class GetCategoryIncomeService {
  static Future<Map<String, dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/income.json');
    return response.data;
  }

  static List<Categories> getCategoriesIncome(data) {
    List<dynamic> categoriesIncomeData = data["categories_income"];
    List<Categories> tempCategoriesIncome = categoriesIncomeData.map((category) {
      return Categories(
        id: category["id"],
        name: category["name"],
        color: category["color"],
      );
    }).toList();
    return tempCategoriesIncome;
  }
}
