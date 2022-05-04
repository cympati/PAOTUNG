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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Text(categotyText),
          const Spacer(),
          FlatButton(
              textColor: AppColors.mainColor,
              child: Text(buttonText),
              onPressed: () {
                print("");
              }),
        ],
      ),
    );
  }
}
