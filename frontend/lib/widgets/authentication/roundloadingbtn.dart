import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RoundLoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final RoundedLoadingButtonController _loginBtnController =
      RoundedLoadingButtonController();
  RoundLoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      color: AppColors.mainColor,
      borderRadius: 12,
      controller: _loginBtnController,
      onPressed: onPressed,
    );
  }
}
