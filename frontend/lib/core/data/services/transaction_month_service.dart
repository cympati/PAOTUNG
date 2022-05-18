import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction/transaction_month.dart';
import 'package:dio/dio.dart';

class GetTransactionMonthService {
  static Future<List<Transactions>> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/transaction/month');
    // print(response.data);
    //print(TransactionMonthResponse.fromJson(response.data).data.date);
    return TransactionMonthResponse.fromJson(response.data).data.date;
  }

  // static List<Transactions> getTransactionsMonth(data) {
  //   List list = data;
  //   List<Transactions> tempTransactionMonth = list.map((transaction) => Transactions.fromJson(transaction)).toList();
  //   return tempTransactionMonth;
  // }
}
