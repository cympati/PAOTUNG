import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class textInputFeild extends StatelessWidget {

  final String title;
  final ValueChanged<String> onChange;
  final bool obscure;

  const textInputFeild({ Key? key, required this.title, required this.onChange, required this.obscure }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          TextField(
            onChanged: onChange,
            obscureText: obscure,
          ),
        ],
      ) 
    );
  }
}