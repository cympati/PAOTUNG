
class PieData {
  List<Data> data = [
    Data(name: 'Part-time', percent: 10, color: 4278359022),
    Data(name: 'From mom', percent: 20, color: 4294488656),
    Data(name: 'Salary', percent: 10, color: 4278190080),
    // Data(name: 'Invest', percent: 15, color: 4279489422),
    Data(name: 'Saving', percent: 30, color: 3911083007),
    Data(name: 'Others', percent: 30, color: 2619846911),
  ];
  PieData(this.data);
  PieData.fromJson(List<Map<String, dynamic>> jsonpiechart) {
    var temp = jsonpiechart.map((e) => Data.fromJson(e));
    data=[...temp];
  }
}

class Data {
  final String name;

  final double percent;

  final int color;

  

  Data({required this.name, required this.percent, required this.color});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json["name"],
      percent: json["percent"],
      color: json["color"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "percent": percent,
      "color": color,
    };
  }
}
