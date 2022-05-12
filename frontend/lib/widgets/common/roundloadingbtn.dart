import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final RoundedLoadingButtonController controller;
  final double bottom;
  const RoundedLoadingBtn({
    Key? key,
    required this.onPressed,
    required this.controller,
    required this.bottom,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: RoundedLoadingButton(
        height: 70,
        width: 420,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        color: AppColors.mainColor,
        borderRadius: 20,
        controller: controller,
        onPressed: onPressed,
      ),
    );
  }
}
