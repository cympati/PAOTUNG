class Transactions {
  String tansactionName;
  String amount;
  String categoryName;
  String dateString;
  int categoryColor;

  Transactions(
      {required this.tansactionName,
      required this.amount,
      required this.dateString,
      required this.categoryName,
      required this.categoryColor});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
        tansactionName: json["transaction_name"],
        amount: json["amount"],
        dateString: json["date_string"],
        categoryName: json["category_name"],
        categoryColor: json["category_color"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "tansactionName": tansactionName,
      "amount": amount,
      "dateString": dateString,
      "categoryName": categoryName,
      "categoryColor": categoryColor
    };
  }
}

class DateTransaction {
  List<Transactions> date;

  DateTransaction({required this.date});

  factory DateTransaction.fromJson(Map<String, dynamic> json) {
    Iterable<Transactions> list= [];
    json.keys.forEach((k) {
      var transactionMonthList =
          json[k] != null ? json[k] as List : List.empty();
      List<Transactions> transactionsMonth = transactionMonthList
          .map<Transactions>((k) => Transactions.fromJson(k))
          .toList();
      // print("$k---------------");
      // print(transactionMonthList);
      // print(transactionsMonth);
      setState() {
        list.addAll(DateTransaction(date: transactionsMonth););
      }
    });
    // print("out");
    // print(transactionMonthList);
    //   print(transactionsMonth);
    // return DateTransaction(date: transactionsMonth);
  }
}

class TransactionMonthResponse {
  bool success;
  String code;
  DateTransaction data;

  TransactionMonthResponse(
      {required this.success, required this.code, required this.data});

  factory TransactionMonthResponse.fromJson(Map<String, dynamic> json) {
    return TransactionMonthResponse(
      success: json['success'],
      code: json['code'],
      data: DateTransaction.fromJson(json['data']),
    );
  }
}
