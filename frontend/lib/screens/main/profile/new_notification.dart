import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
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
  List _types = ['Expense', 'Income'];
  final _formkey = GlobalKey<FormState>();
  final _newnotiController = TextEditingController();
  final RoundedLoadingButtonController _newnotiBtnController =
      RoundedLoadingButtonController();

  void _handleSubmit() {
    if (_formkey.currentState!.validate()) {
      Timer(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacementNamed(context, '/notisetting');
      });
    }
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
              SizedBox(
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
                      Text("Name"),
                      TextFormField(
                  // decoration: InputDecoration(labelText: 'Name'),
                  controller: _newnotiController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
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
              Spacer(),
              RoundedLoadingBtn(
                text: "Add",
                onPressed: () => _handleSubmit(),
                controller: _newnotiBtnController,
                bottom: 80,
              )],
          ),
        ),
      ),
    );
  }
}
