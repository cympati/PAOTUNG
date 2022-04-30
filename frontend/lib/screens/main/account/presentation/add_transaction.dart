import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/widgets/common/customappbar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/dropdownbuttonformfield.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var _transactionval;
  List _types = ['Expense', 'Income'];
  var _categoryval;
  List _category_types = ['Salary', 'Part-time', 'Bonus', 'from mom'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "Add Transactions"),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          DropdownButtons(
            title: "transaction type",
            hinttext: "",
            value: _transactionval,
            onChanged: (value) {
              setState(() {
                _transactionval = value;
              });
            },
            item: _types.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButtons(
            title: "Category",
            hinttext: "",
            value: _categoryval,
            onChanged: (value) {
              setState(() {
                _categoryval = value;
              });
            },
            item: _category_types.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          textInputField(title: "Amount", obscure: false),
          textInputField(title: "Name", obscure: false),
          DatePicker(),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
              text: "Add",
              bottom: 20,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              color: AppColors.mainColor,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
