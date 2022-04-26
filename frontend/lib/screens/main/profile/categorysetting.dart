import 'package:flutter/material.dart';
import 'package:paotung_frontend/widgets/category/category.dart';
import 'package:paotung_frontend/widgets/category/textdefine.dart';
import 'package:paotung_frontend/widgets/common/customappbar.dart';

class CategorySetting extends StatefulWidget {
  const CategorySetting({ Key? key }) : super(key: key);

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(title: 'Category Setting'),
      body: Column(
        children: [
          TextDefine(text1: "Income", text2: "Clear All"),
          Category(color: Color(0xFF26C6DA), text: "Salary"),
          Category(color: Color(0xFFEC407A), text: "Bonus"),
          Category(color: Color(0xFF795548), text: "Collect"),
         Category(color: Color(0xFFF6C008), text: "Interest"),
        ],
      )
    );
  }
}

