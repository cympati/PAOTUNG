import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class textInputFeild extends StatelessWidget {

  final String title;
  final ValueChanged<String> onChange;
  final bool obscure;
  bool isSelected = false;

  textInputFeild({ Key? key, required this.title, required this.onChange, required this.obscure }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
          isSelected = !isSelected      
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: isSelected ?  AppColors.mainColor : Colors.black),),
            TextField(
              onChanged: onChange,
              obscureText: obscure,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor)
                )
              ),
            ),
          ],
        ) 
      ),
    );
  }
}
