class TransactionInfo {
  String tansactionName;
  String amount;
  String categoryName;
  String dateString;
  int categoryColor;

  TransactionInfo(
      {required this.tansactionName,
      required this.amount,
      required this.dateString,
      required this.categoryName,
      required this.categoryColor});

  factory TransactionInfo.fromJson(Map<String, dynamic> json) {
    return TransactionInfo(
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

class TransactionMap {
  List<List<TransactionInfo>> transactionMap;

  TransactionMap({required this.transactionMap});

  factory TransactionMap.fromJson(Map<String, dynamic> json) {
    List<TransactionInfo> list = [];
    Map<String, List<TransactionInfo>> map = {};
    List<List<TransactionInfo>> transactionMapList = [];
    json.forEach((key, value) {
      var transactionMonthList =
      json[key] != null ? json[key] as List : List.empty();
      list = transactionMonthList
          .map<TransactionInfo>((k) => TransactionInfo.fromJson(k))
          .toList();
      map[key] = list;

    });
    map.forEach((key, value) {
          transactionMapList.add(value);
    });

    return TransactionMap(transactionMap: transactionMapList);
  }
}

class TransactionMonthResponse {
  bool success;
  String code;
  TransactionMap data;

  TransactionMonthResponse(
      {required this.success, required this.code, required this.data});

  factory TransactionMonthResponse.fromJson(Map<String, dynamic> json) {
    print("E Art Esus");
    print(TransactionMap.fromJson(json['data']).transactionMap.toString());
    return TransactionMonthResponse(
      success: json['success'],
      code: json['code'],
      data: TransactionMap.fromJson(json['data']),
    );
  }
}
