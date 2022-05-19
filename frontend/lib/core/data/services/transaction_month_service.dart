import 'package:flutter/material.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/error/error_response.dart';
import '../models/transaction/transaction_month.dart';
import 'package:dio/dio.dart';

class GetTransactionMonthService {
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/transaction/month');
    TransactionMonthResponse res = TransactionMonthResponse.fromJson(response.data);
    if (res.success) {
      return res.data.transactionMap;
    } else if (res is ErrorResponse) {
      var error = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 15, right: 15),
        content: Text(res.code),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(error);
    }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return {};
  }
}
