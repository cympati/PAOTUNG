import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TextEditingController timeinput = TextEditingController();

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
          left: 40, right: 40, top: 8, bottom: 0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Time"),
            TextField(
              controller: timeinput,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.timer), labelText: "Select time"),
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
                  String formattedTime =
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
    );
  }
}
