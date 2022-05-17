import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/dropdown_form_field.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/common/time_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({Key? key}) : super(key: key);

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  var _transactionval;
  var formattedDate = "";
  var formattedTime = "";
  List _types = ['Expense', 'Income'];
  final _formkey = GlobalKey<FormState>();
  final _newnotiController = TextEditingController();
  final RoundedLoadingButtonController _newnotiBtnController =
      RoundedLoadingButtonController();
  DateTime? pickedDate;
  bool isSubmit = false;
  TextEditingController dateinput = TextEditingController();
  DateTime? selectedDate;
  TextEditingController timeinput = TextEditingController();
  TimeOfDay? pickedTime;
  String? name;
  String? dateTime;

  // void _handleSubmit() {
  //   if (_formkey.currentState!.validate()) {
  //     Timer(const Duration(milliseconds: 1500), () {
  //       Navigator.pushReplacementNamed(context, '/notisetting');
  //     });
  //   }
  // }

  void _notificationCall() async {
    var format = formattedDate + "T" + formattedTime + "Z";
    //print(format);
    var addNotification = await GetNotification.newNotification(name!, format);
    if (addNotification is ErrorResponse) {
      showAlertDialog(context, addNotification.message);
      _newnotiBtnController.reset();
    } else {
      _newnotiBtnController.success();
      _notificationNavigate();
    }
  }

  void _notificationNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "New Notification"),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    onChanged: (value) {},
                    controller: _newnotiController,
                    onSaved: (value) {
                      name = value;
                    },
                    //controller: _newnotiController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                    },
                    autovalidateMode: isSubmit
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled),
              ),
              // DropdownButtons(
              //   title: "transaction type",
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
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                            labelText: "Select Date"),
                        readOnly: true,
                        onSaved: (value) {
                          selectedDate = value as DateTime?;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            'Please select date';
                          }
                          return null;
                        },
                        onTap: () async {
                          pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            print(pickedDate);
                            formattedDate =
                                pickedDate!.toIso8601String().substring(0, 10);
                            String formattedDateShow =
                                DateFormat('dd-MM-yyyy').format(pickedDate!);
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
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Time"),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            'Please select time';
                          }
                          return null;
                        },
                        controller: timeinput,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.timer),
                            labelText: "Select time"),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            print(pickedTime.format(context));
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            print(parsedTime);
                            formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime);

                            setState(() {
                              timeinput.text = formattedTime;
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              RoundedLoadingBtn(
                text: "Add",
                controller: _newnotiBtnController,
                bottom: 80,
                onPressed: () {
                  setState(() {
                    isSubmit = true;
                  });
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isSubmit = false;
                    _notificationCall();
                  }
                  //print("mmujyuutjutjtt ");
                  _newnotiBtnController.reset();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
