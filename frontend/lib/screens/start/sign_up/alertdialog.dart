import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

showAlertDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context, rootNavigator: true).pop();
        });
        return AlertDialog(
          title: const Text('SOMETHING WRONG!', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.mainColor,
          content: Text(message, style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      });
}
