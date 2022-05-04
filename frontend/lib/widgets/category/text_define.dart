import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class TextDefine extends StatelessWidget {
  final String categotyText;
  final String buttonText;
  const TextDefine(
      {Key? key, required this.categotyText, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10, left: 40, right: 40),
      child: Row(
        children: [
          Text(categotyText, style: TextStyle(fontSize: 16,color: AppColors.mainColor),
          ),
          const Spacer(),
          FlatButton(
              // textColor: AppColors.mainColor,
              child: Text(buttonText, style:  TextStyle(fontSize: 14, color: AppColors.grey),),
              onPressed: () {
                print("Delete category");
              }),
        ],
      ),
    );
  }
}
