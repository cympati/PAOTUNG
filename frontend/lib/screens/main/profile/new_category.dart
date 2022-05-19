import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/categories.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/response/response.dart';
import 'package:paotung_frontend/core/data/services/category_expense_service.dart';
import 'package:paotung_frontend/core/data/services/category_income_service.dart';

import 'package:paotung_frontend/screens/main/profile/category_setting.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/dropdown_form_field.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final _formkey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final RoundedLoadingButtonController _newcategoryBtnController =
      RoundedLoadingButtonController();
  String? name;

  // String? color;
  String? transactionType;
  int? selectedColor;
  bool isSubmit = false;

  // final RoundedButton _categoryBtnController = RoundedButton();
  Color mycolor = Colors.lightBlue;

  //var _transactionval;
  List _types = ['Expense', 'Income'];

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  // Color color = AppColors.mainColor;
  Color pickerColor = AppColors.secondaryColor;

  // void _handleSubmit() {
  //   if (_formkey.currentState!.validate()) {
  //     Timer(const Duration(milliseconds: 1500), () {
  //       Navigator.pushReplacementNamed(context, '/categorysetting');
  //     });
  //   }
  // }

  // Future<dynamic> addCategory(
  //     String name, String transactionType, int color) async {
  //   var response = await GetCategoryExpenseService.addCategoryService(
  //       name, transactionType, color);
  //       if (response is AddCategoryResponse) {
  //         read
  //       }
  // }

  void _categoryCall() async {
    var hex = '${mycolor.value.toRadixString(16).substring(2)}';
    final int selectedColor = int.parse("0x$hex");
    print(selectedColor);
    var addCategory = await GetCategoryExpenseService.addCategoryService(
        name!, transactionType!, selectedColor);
    if (addCategory is ErrorResponse) {
      showAlertDialog(context, addCategory.message);
      _newcategoryBtnController.reset();
    } else {
      _newcategoryBtnController.success();
      _categoryNavigate();
    }
  }

  void _categoryNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      // Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/categorysetting');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "New Category"),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 6, bottom: 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Name'),
                        TextFormField(
                          // decoration: InputDecoration(labelText: 'Name'),
                          onChanged: (value) {
                            name = value;
                          },
                          controller: _categoryController,
                          onSaved: (value) {
                            name = value;
                            //print(name);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter category';
                            }
                          },
                          autovalidateMode: isSubmit
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                        ),
                      ])),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Transaction Type'),
                    Container(
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a transaction type';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        isDense: false,
                        value: transactionType,
                        hint: const Text('Select transaction type'),
                        isExpanded: true,
                        items: _types.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            transactionType = value;
                          });
                        },
                        onSaved: (value) {
                          transactionType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color"),
                      TextFormField(
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select the color';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          selectedColor = value as int?;
                        },
                        onChanged: (value) {},

                        // autovalidateMode: isSubmit
                        //     ? AutovalidateMode.onUserInteraction
                        //     : AutovalidateMode.disabled,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.mainColor)),
                            prefixIcon: Icon(
                              Icons.circle,
                              color: mycolor,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
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
                                              onPressed: () => Navigator.of(
                                                      context,
                                                      rootNavigator: true)
                                                  .pop())
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
              RoundedLoadingBtn(
                text: 'Add',
                bottom: 40,
                controller: _newcategoryBtnController,
                onPressed: () {
                  setState(() {
                    isSubmit = true;
                  });
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isSubmit = false;
                    _categoryCall();
                  }
                  _newcategoryBtnController.reset();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
