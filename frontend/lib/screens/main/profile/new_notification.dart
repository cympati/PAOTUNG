import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/time_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewNotification extends StatefulWidget {
  final Function? readJson;

  const NewNotification({Key? key, required this.readJson}) : super(key: key);

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  var formattedDate = "";
  var formattedTime = "";
  final _formkey = GlobalKey<FormState>();
  final _notificationNameKey = TextEditingController();
  final _dateKey = TextEditingController();
  final _timeKey = TextEditingController();
  final RoundedLoadingButtonController _newnotiBtnController =
      RoundedLoadingButtonController();
  DateTime? pickedDate;
  bool isSubmit = false;
  TextEditingController dateinput = TextEditingController();
  DateTime? selectedDate;
  TextEditingController timeinput = TextEditingController();
  TimeOfDay? pickedTime;

  // String? name;
  // String? dateTime;

  void initState() {
    _dateKey.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _timeKey.text = DateFormat('hh:mm a').format(DateTime.now());
    formattedTime = DateFormat('hh:mm:ss').format(DateTime.now());
    print(DateTime.now());
    super.initState();
  }

  void _notificationCall() async {
    // var formattedDateTime = formattedDate + "T" + formattedTime + "Z";
    var formattedDateTime = formattedDate + "T" + formattedTime + "Z";
    print(formattedDateTime);
    print(_notificationNameKey.text);
    var addNotification = await GetNotification.newNotification(
        _notificationNameKey.text, formattedDateTime);
    print(addNotification);
    if (addNotification is ErrorResponse) {
      showAlertDialog(context, addNotification.message);
      _newnotiBtnController.reset();
      _formkey.currentState!.reset();
    } else {
      await widget.readJson!();
      _newnotiBtnController.success();
      _notificationNavigate();
    }
  }

  void _notificationNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.of(context, rootNavigator: true).pop();
      // Navigator.restorablePushReplacementNamed(context, '/notisetting');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CloseAppBar(title: "New Notification"),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 6, bottom: 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name"),
                      TextFormField(
                          controller: _notificationNameKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction),
                    ]), // ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 6, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date"),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == "" || value!.isEmpty) {
                          return 'Please select date';
                        }
                        return null;
                      },
                      controller: _dateKey,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(
                              days: 365,
                            )));
                        if (pickedDate != null) {
                          print(pickedDate);
                          formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          _dateKey.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          // print(formattedDate);
                          print(_dateKey.text);
                        } else {
                          print("Date is not selected");
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 8, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Time"),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == "" || value!.isEmpty) {
                          return 'Please select date';
                        }
                        return null;
                      },
                      controller: _timeKey,
                      decoration:
                          InputDecoration(suffixIcon: Icon(Icons.timer)),
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
                          print(parsedTime.toString() + "parsedTime");
                          formattedTime =
                              DateFormat('hh:mm:ss').format(parsedTime);
                          print(formattedTime + "formattedTime");
                          _timeKey.text =
                              DateFormat('hh:mm a').format(parsedTime);
                          print(_timeKey.text + "_timeKey.text");
                        } else {
                          print("Time is not selected");
                        }
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 230,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 35),child: RoundedLoadingBtn(
                text: "Add",
                controller: _newnotiBtnController,
                bottom: 40,
                onPressed: () {
                  setState(() {
                    isSubmit = true;
                  });
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isSubmit = false;
                    _notificationCall();
                  }
                  _newnotiBtnController.reset();
                },
              ),
              ) ,


            ],
          ),
        ),
      ),
    );
  }
}
