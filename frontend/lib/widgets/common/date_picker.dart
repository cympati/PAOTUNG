import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateinput = TextEditingController();
  DateTime? Date;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
          left: 40, right: 40, top: 6, bottom: 0),
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
                String formattedDate =
                    DateFormat('dd-MM-yyyy HH:mm:ss').format(pickedDate);

                setState(() {
                  dateinput.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          )
        ],
      ),
    );
  }
}
