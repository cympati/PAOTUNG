import 'package:flutter/material.dart';

class TransactionTypeDropdown extends StatefulWidget {
  
  const TransactionTypeDropdown({Key? key}) : super(key: key);

  @override
  State<TransactionTypeDropdown> createState() =>
      _TransactionTypeDropdownState();
}

class _TransactionTypeDropdownState extends State<TransactionTypeDropdown> {

  var _categortval;
  List _types = ['Expense', 'Income'];

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
