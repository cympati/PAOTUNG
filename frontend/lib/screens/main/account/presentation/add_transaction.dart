import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/category_expense_service.dart';
import 'package:paotung_frontend/core/data/services/category_income_service.dart';
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

import '../../../../core/data/models/category/categories.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formkey = GlobalKey<FormState>();
  final List<String> _types = ['Expense', 'Income'];
  final Categories _default =
      Categories(id: 0, name: 'Uncategorized', color: 1461410152);
  final RoundedLoadingButtonController _newtransactionBtnController =
      RoundedLoadingButtonController();
  String? transactionType;
  String? transactionName;
  double? amount;
  DateTime? pickedDate;
  bool isSubmit = false;
  TextEditingController dateinput = TextEditingController();
  DateTime? selectedDate;
  String? _categoryval;
  List<Categories> _categoryTypes = [];
  var _selectedCategory = "";

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  Future<void> _checkTransaction() async {
    List<Categories> categoryIsExpense =
        await GetCategoryExpenseService.getData();
    List<Categories> categoryIsIncome =
        await GetCategoryIncomeService.getData();
    setState(() {
      transactionType == "Expense"
          ? _categoryTypes = [_default, ...categoryIsExpense]
          : _categoryTypes = [_default, ...categoryIsIncome];
      _categoryval = 'Uncategorized';
    });
  }

  void _transactionCall() async {
    final DateTime selectedDate = pickedDate?.toIso8601String() as DateTime;
    var newTransaction = await GetTransactionTodayService.addTransactionService(
        transactionType!, transactionName!, amount!, selectedDate);
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
        appBar: const CloseAppBar(title: "Add Transactions"),
        body: ListView(
          key: _formkey,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 0, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Transaction Type'),
                        DropdownButtonFormField<String>(
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
                              _categoryval = 'Uncategorized';
                              transactionType = value;
                            });
                            _checkTransaction();
                          },
                          onSaved: (value) {
                            transactionType = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 6, bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Category'),
                        DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          isDense: false,
                          value: _categoryval,
                          hint: const Text('Select transaction type'),
                          isExpanded: false,
                          items: _categoryTypes.map((value) {
                            return DropdownMenuItem(
                                value: value.name, child: Text(value.name));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _categoryval = value;
                            });
                          },
                          onSaved: (value) {
                            _categoryval = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 6, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Amount'),
                          TextFormField(
                            // decoration: InputDecoration(labelText: 'Amount'),
                            onChanged: (value) {},
                            onSaved: (value) {
                              amount = value as double?;
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
                        ],
                      )),
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
                              onChanged: (value) {},
                              onSaved: (value) {
                                transactionName = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter transaction name';
                                }
                              },
                              autovalidateMode: isSubmit
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                            ),
                          ])),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 6, bottom: 0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Date"),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select date';
                              }
                              return null;
                            },
                            controller: dateinput,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.calendar_today),
                                labelText: "Select Date"),
                            readOnly: true,
                            onSaved: (value) {
                              selectedDate = value as DateTime?;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    pickedDate.toIso8601String();
                                String formattedDateShow =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);

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
                  const SizedBox(
                    height: 50,
                  ),
                  RoundedLoadingBtn(
                    text: "Add",
                    bottom: 30,
                    controller: _newtransactionBtnController,
                    onPressed: () {
                      setState(() {
                        print("0000000000");
                        isSubmit = true;
                      });
                      print("11111111111");
                      if (_formkey.currentState!.validate()) {
                        print("444444444444444");
                        _formkey.currentState!.save();
                        isSubmit = false;
                        _transactionCall();
                      }
                      print("9999999999999");
                      _newtransactionBtnController.reset();
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
