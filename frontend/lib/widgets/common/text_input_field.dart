import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class textInputField extends StatefulWidget {
  final String title;
  final bool obscure;
  final String text;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;

  textInputField(
      {Key? key,
      required this.title,
      required this.obscure,
      required this.text,
      required this.onChanged,
      this.controller,
      this.validator,
      this.formKey})
      : super(key: key);

  @override
  State<textInputField> createState() => _textInputFieldState();
}

class _textInputFieldState extends State<textInputField> {
  late final TextEditingController controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = TextEditingController(text: widget.text);
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

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
