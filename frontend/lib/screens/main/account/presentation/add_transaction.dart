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
  final Function? backTrigger;

  const AddTransaction({Key? key, this.backTrigger}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formkey = GlobalKey<FormState>();
  final _transactionNameKey = TextEditingController();
  final _amountKey = TextEditingController();
  final _dateKey = TextEditingController();
  final List<String> _types = ['Expense', 'Income'];
  final Categories _default =
      Categories(id: 0, name: 'Uncategorized', color: 1461410152);
  final RoundedLoadingButtonController _newtransactionBtnController =
      RoundedLoadingButtonController();
  String? transactionType;
  DateTime? pickedDate;
  String? formattedDate;
  bool isSubmit = false;
  int? _categoryIdInput;
  List<Categories> _categoryTypes = [];

  @override
  void initState() {
    _dateKey.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    formattedDate = DateTime.now().toIso8601String().substring(0, 20) + "000Z";
    transactionType = _types[0];
    _checkTransaction();
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
      _categoryIdInput = _categoryTypes[0].id;
    });
  }

  void _transactionCall() async {
    print(_amountKey.text);
    print(transactionType);
    print(_transactionNameKey.text);
    print(formattedDate);
    print(_categoryIdInput);

    var newTransaction = await GetTransactionTodayService.addTransactionService(
        transactionType!.toLowerCase(),
        _transactionNameKey.text,
        double.parse(_amountKey.text),
        formattedDate!,
        _categoryIdInput!);
    if (newTransaction is ErrorResponse) {
      showAlertDialog(context, newTransaction.message);
      _newtransactionBtnController.reset();
      _formkey.currentState!.reset();
    } else {
      _newtransactionBtnController.success();
      _transactionNavigate();
    }
  }

  void _transactionNavigate() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CloseAppBar(title: "Add Transactions"),
        body: Form(
            key: _formkey,
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                _checkTransaction();
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
                            DropdownButtonFormField<int>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isNaN || value.isNegative) {
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
                              value: _categoryIdInput,
                              hint: const Text('Select transaction type'),
                              isExpanded: false,
                              items: _categoryTypes.map((value) {
                                return DropdownMenuItem(
                                    value: value.id, child: Text(value.name));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _categoryIdInput = value;
                                });
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
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _amountKey,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter amount';
                                  } else if (value.contains('-') ||
                                      value.contains('+') ||
                                      double.parse(value).isNaN) {
                                    return 'Please enter valid amount form as 999, 999.00';
                                  }
                                  return null;
                                },
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _transactionNameKey,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter transaction name';
                                    } return null;
                                  },
                                ),
                              ])),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 6, bottom: 0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Date"),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == "" || value!.isEmpty) {
                                    return 'Please select date';
                                  }
                                  return null;
                                },
                                controller: _dateKey,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.calendar_today)),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now().add(const Duration(days: 365,)));
                                  if (pickedDate != null) {
                                    formattedDate = pickedDate
                                            .toIso8601String()
                                            .substring(0, 20) +
                                        "000Z";
                                    String formattedDateShow =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      _dateKey.text = formattedDateShow;
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
                            _transactionCall();
                            isSubmit = false;
                          }
                          _newtransactionBtnController.reset();

                          print("9999999999999");
                        },
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
