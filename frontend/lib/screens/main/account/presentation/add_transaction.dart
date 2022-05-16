import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/transaction_today_service.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/dropdown_form_field.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formkey = GlobalKey<FormState>();
  String? transactionType;
  String? transactionName;
  double? Amount;
  bool isSubmit = false;
  TextEditingController dateinput = TextEditingController();
  DateTime? Date;
  final RoundedLoadingButtonController _newtransactionBtnController =
      RoundedLoadingButtonController();
  //var _transactionval;
  List _types = ['Expense', 'Income'];
  var _categoryval;
  List _category_types = ['Salary', 'Part-time', 'Bonus', 'from mom'];

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  void _transactionCall() async {
    var newTransaction = await GetTransactionTodayService.addTransactionService(
        transactionType!, transactionName!, Amount!, Date!);
    if (newTransaction is ErrorResponse) {
      showAlertDialog(context, newTransaction.message);
      _newtransactionBtnController.reset();
    } else {
      _newtransactionBtnController.success();
      _transactionNavigate();
    }
  }

  void _transactionNavigate() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CloseAppBar(title: "Add Transactions"),
        body: ListView(
          key: _formkey,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
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
                          //print(transactionType);
                        },
                        title: "Transaction type",
                        value: transactionType,
                        hinttext: '',
                        onChanged: (value) {
                          setState(() {
                            transactionType = value;
                            // print(_transactionval);
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
                  FormField(builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // labelText: 'Transaction type',
                      ),
                      // isEmpty: _transactionval == '',
                      child: DropdownButtons(
                        onSaved: (value) {
                          _categoryval = value;
                          //print(transactionType);
                        },
                        title: "Category",
                        value: _categoryval,
                        hinttext: '',
                        onChanged: (value) {
                          setState(() {
                            _categoryval = value;
                            // print(_transactionval);
                          });
                        },
                        item: _category_types.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      onChanged: (value) {},
                      onSaved: (value) {
                        Amount = value as double?;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                      },
                      autovalidateMode: isSubmit
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      // title: "Amount",
                      // obscure: false,
                      // text: '',
                      // onChanged: (e) {
                      //   print("text");
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) {},
                      onSaved: (value) {
                        transactionName = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                      },
                      autovalidateMode: isSubmit
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                    ),
                  ),
                  // textInputField(
                  //   title: "Name",
                  //   obscure: false,
                  //   text: '',
                  //   onChanged: (e) {
                  //     print("text");
                  //   },
                  // ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date"),
                          TextFormField(
                            controller: dateinput,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.calendar_today),
                                labelText: "Select Date"),
                            readOnly: true,
                            onSaved: (value) {
                              Date = value as DateTime?;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    pickedDate.toIso8601String();
                                String formattedDateShow =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(formattedDate);

                                setState(() {
                                  dateinput.text = formattedDateShow;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  //DatePicker(),
                  SizedBox(
                    height: 50,
                  ),
                  RoundedLoadingBtn(
                    text: "Add",
                    bottom: 30,
                    controller: _newtransactionBtnController,
                    onPressed: () {
                      setState(() {
                        isSubmit = true;
                      });
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        isSubmit = false;
                        _transactionCall();
                      }
                      _newtransactionBtnController.reset();
                    },
                    // color: AppColors.mainColor,
                    // textColor: Colors.white
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
