import 'package:flutter/material.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionTodayService {
  static Future<dynamic> addTransactionService(
    String transactionType,
    String transactionName,
    double amount,
    DateTime selectedDate,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(apiEndPoint + '/transaction/add',
          data: {
            'amount': amount,
            'name': transactionName,
            'transaction_type': transactionType,
            'date': selectedDate,
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      TransactionResponse res = TransactionResponse.fromJson(response.data);
      return res;
      //  if (res.success) {
      //   return res;
      // } else if (response is ErrorResponse) {
      //   var error = SnackBar(
      //     behavior: SnackBarBehavior.floating,
      //     margin: const EdgeInsets.only(left: 15, right: 15),
      //     content: Text(res.message),
      //     action: SnackBarAction(
      //       label: 'OK',
      //       onPressed: () {},
      //     ),
      //   );
      //   // ScaffoldMessenger.of(context).showSnackBar(error);
      // }
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse erroe = ErrorResponse.fromJson(e.response?.data);
      }
    }
    return null;
  }

  static Future<List<Transactions>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/transaction/today');
    // print(response.data);
    return TransactionResponse.fromJson(response.data).data;
  }

//   static List<Transactions> getTransactionsToday(data) {
//     List list = data;
//     List<Transactions> tempTransactionToday = list.map((transaction) => Transactions.fromJson(transaction)).toList();
//     return tempTransactionToday;
//   }
}
