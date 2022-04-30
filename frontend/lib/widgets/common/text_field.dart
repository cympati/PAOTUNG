import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class textInputField extends StatefulWidget {
  final String title;
  final bool obscure;

  textInputField({
    Key? key,
    required this.title,
    required this.obscure,
  }) : super(key: key);

  @override
  State<textInputField> createState() => _textInputFieldState();
}

class _textInputFieldState extends State<textInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title),
              TextField(
                obscureText: widget.obscure,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor))),
                onSubmitted: (value) {
                  print("Title name: $value");
                },
                
              ),
            ],
          ),
        ));
  }
}
