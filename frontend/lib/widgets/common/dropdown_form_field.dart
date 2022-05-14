// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';

class DropdownButtons extends StatelessWidget {
  final String title;
  var item;
  final onChanged;
  final String hinttext;
  final onSaved;
  var value;
  DropdownButtons({
    Key? key,
    required this.title,
    required this.item,
    required this.onChanged,
    required this.hinttext,
    this.onSaved,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            DropdownButtonFormField(
              items: item,
              onChanged: onChanged,
              onSaved: onSaved,
              hint: Text(
                hinttext,
                style: TextStyle(fontSize: 10),
              ),
              value: value,
            )
          ],
        ),
      ),
    );
  }
}
