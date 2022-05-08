import '../models/transaction/transaction.dart';
import 'package:dio/dio.dart';

class GetTransactionService {
  static Future<List<dynamic>> getData() async {
    Response response =
    await Dio().get('https://wwwii.bsthun.com/mock/paotung/transaction.json');
    return response.data;
  }

  static List<Transactions> getTransactions(data) {
    List list = data;
    List<Transactions> tempTransaction = list.map((transaction) => Transactions.fromJson(transaction)).toList();
    return tempTransaction;
  }
}
