import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category/piedata.dart';
import 'package:dio/dio.dart';


class GetPieDataExpenseService {
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          apiEndPoint + '/category/expense' ,
          options: Options(headers: {"Authorization": "Bearer " + (userToken ?? "")}));
       List<PieData> pieData = PieDataResponse.fromJson(response.data).piedata;
      return pieData;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        print(error);
        return error;
      }
    }
  }
}