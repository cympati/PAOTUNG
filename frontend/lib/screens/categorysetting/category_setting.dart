import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/common/customappbar.dart';

class CategorySetting extends StatelessWidget {
  const CategorySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(
        title: 'New Category',
      ),
    );
  }
}
