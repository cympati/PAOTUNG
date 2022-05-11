import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error!'),
      backgroundColor: AppColors.mainColor,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
