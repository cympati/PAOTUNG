import 'package:paotung_frontend/core/data/models/category/piedata.dart';
import '../models/category/piedata.dart';
import 'package:dio/dio.dart';

class GetDashboardExpenseService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/expense.json');
    return response.data;
  }

  static List<PieData> getPieData(data) {
    List list = data;
    List<PieData> tempDashboardExpense = list.map((piedata) => PieData.fromJson(piedata)).toList();
    return tempDashboardExpense;
  }
}