import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

import '../../screens/main/profile/newcategory.dart';

class FloattingButton extends StatelessWidget {
  final Color color;
  const FloattingButton({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NewCategory()));
      },
      backgroundColor: AppColors.mainColor,
      child: const Icon(Icons.add),
    );
  }
}
