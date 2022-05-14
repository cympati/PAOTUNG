import 'package:paotung_frontend/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionTodayService {
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
