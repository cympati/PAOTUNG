import 'dart:html';

import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String createdAt;

  @HiveField(1)
  final String updatedAt;

  @HiveField(2)
  final String type;
  
  @HiveField(3)
  final String category;

  @HiveField(4)
  final int amount;

  @HiveField(5)
  final String name;

  @HiveField(6)
  final String date;

  

  ExpenseModel({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
    required this.type,
    required this.name,
    required this.date,
  });

  @override
  String toString() {
    return 'ExpenseModel(createdAt: $createdAt, updatedAt: $updatedAt,type: $type, category: $category, amount: $amount, name: $name, date: $date)';
  }
}
