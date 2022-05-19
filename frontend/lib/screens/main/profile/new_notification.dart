import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/notification_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/time_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({Key? key}) : super(key: key);

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  var formattedDate = "";
  var formattedTime = "";
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
      appBar: const CloseAppBar(title: "New Notification"),
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
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 6, bottom: 0),
                child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Text("Name"),
                      TextFormField(
                        // decoration: InputDecoration(labelText: 'Name'),
                        controller: _newnotiController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                      ),
                    ])),
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
              ),
              const DatePicker(),
              const TimePicker(),
              const Spacer(),
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
