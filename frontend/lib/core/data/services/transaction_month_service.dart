import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionMonthService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/transaction.json');
    return response.data;
  }

  static List<Transactions> getTransactionsMonth(data) {
    List list = data;
    List<Transactions> tempTransactionMonth = list.map((transaction) => Transactions.fromJson(transaction)).toList();
    return tempTransactionMonth;
  }
}
