import 'package:flutter/material.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/response/add_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionTodayService {
  static Future<dynamic> addTransactionService(
      String transactionType,
      String transactionName,
      double amount,
      String selectedDate,
      int categoryId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(apiEndPoint + '/transaction/add',
          data: {
            'category_id': categoryId,
            'amount': amount,
            'name': transactionName,
            'transaction_type': transactionType,
            'date': selectedDate,
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      AddTransactionResponse res =
          AddTransactionResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return List.empty();
  }

  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
      Response response = await dio.get(apiEndPoint + '/transaction/today');
      TransactionResponse res = TransactionResponse.fromJson(response.data);
        return res.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return List.empty();
  }
}
