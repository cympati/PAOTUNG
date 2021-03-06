import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class textInputField extends StatefulWidget {
  final String title;
  final bool obscure;
  final String text;

  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;

  textInputField(
      {Key? key,
      required this.title,
      required this.obscure,
      required this.text,
      required this.onChanged,
      this.controller,
      this.validator,
      this.onSaved,
      this.autovalidateMode,
      this.formKey})
      : super(key: key);

  @override
  State<textInputField> createState() => _textInputFieldState();
}

class _textInputFieldState extends State<textInputField> {

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            TextFormField(
              autovalidateMode: widget.autovalidateMode,
              onSaved: widget.onSaved,
              validator: widget.validator,
              controller: widget.controller,
              obscureText: widget.obscure,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor))),
            ),
          ],
        ),
      ),
    ));
  }
}
