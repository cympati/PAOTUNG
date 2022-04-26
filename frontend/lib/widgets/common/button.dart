import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 80, left: 40, right: 40),
      width: double.infinity,
      child: FlatButton(
        child: Text(
          text,
          style: TextStyle( fontSize: 16),
        ),
        onPressed: onPressed,
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
