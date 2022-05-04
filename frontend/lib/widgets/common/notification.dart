import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class NotificationTitle extends StatelessWidget {
  final String title;
  const NotificationTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.lightgrey))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      decoration: TextDecoration.none)),
              const Icon(Icons.close),
            ],
          ),
        ),
      ),
    );
  }
}
