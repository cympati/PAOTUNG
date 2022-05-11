import '../models/category/piedata.dart';
import 'package:dio/dio.dart';

class GetDashboardIncomeService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/dashboard_show_income.json');
    return response.data;
  }

  static PieData getPieData(data) {
    PieData pieData = PieData.fromJson(data); 
    return pieData;
  }
}