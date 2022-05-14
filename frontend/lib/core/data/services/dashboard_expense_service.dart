import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/piedata.dart';
import 'package:dio/dio.dart';

// class GetDashboardExpenseService {
//   static Future<List<dynamic>> getData() async {
//     Response response =
//     await Dio().get('https://wwwii.bsthun.com/mock/paotung/dashboard_show_expense.json');
//     return response.data;
//   }

//   static PieData getPieData(data) {
//     PieData pieData = PieData.fromJson(data); 
//     return pieData;
//   }
// }

class GetDashboardExpenseService {
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          apiEndPoint + '/category/expense' ,
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
       PieData pieData = PieData.fromJson(response.data);
      return pieData;
    } on DioError catch (e) {
      // if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
      //   ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
      //   return error;
      // }
    }
    return "";
  }
}