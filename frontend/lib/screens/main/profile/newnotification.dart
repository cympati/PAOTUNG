import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/widgets/common/customappbar.dart';
import 'package:paotung_frontend/widgets/common/date_picker.dart';
import 'package:paotung_frontend/widgets/common/dropdownbuttonformfield.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:paotung_frontend/widgets/common/time_picker.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({Key? key}) : super(key: key);

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  var _transactionval;
  List _types = ['Expense', 'Income'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: "New Notification"),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          textInputField(title: "Name", obscure: false),
          DropdownButtons(
            title: "transaction type",
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
          DatePicker(),
          TimePicker(),
          Spacer(),
          RoundedButton(
              text: "Add",
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationSetting()));
              },
              color: AppColors.mainColor,
              bottom: 20,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
