import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/piedata.dart';
import 'package:dio/dio.dart';


class GetPieChartIncomeService {
  static Future<List<PieData>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('user');
    
    try {
      Response response = await Dio().get(
          apiEndPoint + '/category/income' ,
          options: Options(headers: {"Authorization": "Bearer " + (userToken ?? "")}));
       List<PieData> pieData = PieDataResponse.fromJson(response.data).piedata;
      return pieData;
    } on DioError catch (e) {
  
    }
    return List.empty();
  }
}