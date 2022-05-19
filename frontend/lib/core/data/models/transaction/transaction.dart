class Transactions {
  String transactionName;
  String date;
  String amount;
  String categoryName;
  int categoryColor;

  Transactions(
      {required this.transactionName,
      required this.date,
      required this.amount,
      required this.categoryName,
      required this.categoryColor});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
        transactionName: json["transaction_name"],
        date: json["date_string"],
        amount: json["amount"],
        categoryName: json["category_name"],
        categoryColor: json["category_color"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "tansactionName": transactionName,
      "date": date,
      "amount": amount,
      "categoryName": categoryName,
      "categoryColor": categoryColor
    };
  }
}

class TransactionResponse {
  bool success;
  String code;
  List<Transactions> data;

  TransactionResponse(this.success, this.code, this.data, );

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    var transaction = json['data'] != null ? json['data'] as List : List.empty();
    List<Transactions> tempTransaction =
        transaction.map((e) => Transactions.fromJson(e)).toList();

    return TransactionResponse(
      json['success'],
      json['code'],
      tempTransaction,
    );
  }
}

