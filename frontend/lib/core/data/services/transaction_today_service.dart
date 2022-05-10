import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionTodayService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/transaction.json');
    return response.data;
  }

  static List<Transactions> getTransactionsToday(data) {
    List list = data;
    List<Transactions> tempTransactionToday = list.map((transaction) => Transactions.fromJson(transaction)).toList();
    return tempTransactionToday;
  }
}
