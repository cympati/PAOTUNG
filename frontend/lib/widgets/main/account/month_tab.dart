import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class MonthTab extends StatelessWidget {
  const MonthTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Month", style: TextStyle(color: AppColors.grey, fontSize: 14),)
          
        ],
      ),
    );
  }
}