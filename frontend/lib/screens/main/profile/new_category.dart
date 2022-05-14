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
  var _transactionval;
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
    //print(hex);
    final int selectedColor = int.parse("0x$hex");
    print(selectedColor);
    var addCategory = await GetCategoryExpenseService.addCategoryService(
        name!, transactionType!, selectedColor);
    // print(selectedColor);
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
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  controller: _categoryController,
                  onSaved: (value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter category';
                    }
                  },
                ),
              ),
              // textInputField(
              //   title: "Category",
              //   obscure: false,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the category';
              //     }
              //     return null;
              //   },
              //   controller: _categoryController,
              //   // autovalidateMode: isSubmit
              //   //     ? AutovalidateMode.onUserInteraction
              //   //     : AutovalidateMode.disabled,
              //   text: '',
              //   onChanged: (value) {},
              // ),
              FormField(builder: (FormFieldState state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // labelText: 'Transaction type',
                  ),
                  // isEmpty: _transactionval == '',
                  child: DropdownButtons(
                    onSaved: (value) {
                      transactionType = value;
                    },
                    title: "Transaction type",
                    value: _transactionval,
                    hinttext: '',
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
                );
              }),
              // DropdownButtons(
              //   // onSaved: (value) {
              //   //   _transactionval = value;
              //   // },
              //   // validator: (value) {
              //   //   if (value!.isEmpty) {
              //   //     return 'Please select one';
              //   //   }
              //   //   return null;
              //   // },
              //   title: "Transaction type",
              //   hinttext: "",
              //   value: _transactionval,
              //   onChanged: (value) {
              //     setState(() {
              //       _transactionval = value;
              //     });
              //   },
              //   item: _types.map((value) {
              //     return DropdownMenuItem(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select the color';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          mycolor = value as Color;
                        },
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
              // RoundedButton(
              //     text: "Add",
              //     bottom: 80,
              //     onPressed: () {
              //       setState(() {
              //         isSubmit = true;
              //         Navigator.pushReplacementNamed(context, '/categorysetting');
              //       });
              //       if (_formkey.currentState!.validate()) {
              //         _formkey.currentState!.save();
              //         isSubmit = false;
              //       }
              //     },
              //     color: AppColors.mainColor,
              //     textColor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
