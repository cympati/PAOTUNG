import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/categories.dart';
import 'package:paotung_frontend/core/data/services/category_expense_service.dart';
import 'package:paotung_frontend/core/data/services/category_income_service.dart';

import 'package:paotung_frontend/screens/main/profile/category_setting.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/dropdown_form_field.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  Color mycolor = Colors.lightBlue;
  var _transactionval;
  List _types = ['Expense', 'Income'];


  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }



  Color color = AppColors.mainColor;
  Color pickerColor = AppColors.secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "New Category"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            textInputField(
              title: "Category",
              obscure: false,
              text: '',
              onChanged: (value) {},
            ),
            DropdownButtons(
              title: "Transaction type",
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
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Color"),
                    TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.mainColor)),
                          prefixIcon: Icon(
                            Icons.circle,
                            color: mycolor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Pick a color!'),
                                      content: SingleChildScrollView(
                                        child: BlockPicker(
                                          pickerColor: mycolor,
                                          onColorChanged: (Color color) {
                                            setState(() {
                                              mycolor = color;
                                              print(color);
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            child: const Text('DONE'),
                                          onPressed: () => Navigator.of(context, rootNavigator: true).pop()
                                          )
                                      ],
                                    );
                                  });
                            },
                          )),
                    ),
                  ],
                ),
              ),
            )),
            Spacer(),
            RoundedButton(
                text: "Add",
                bottom: 80,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CategorySetting()));
                },
                color: AppColors.mainColor,
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}