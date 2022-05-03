// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/profile/newcategory.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';

class CategorySetting extends StatefulWidget {
  const CategorySetting({Key? key}) : super(key: key);

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
// List<Object> incomeCategories = [{color:Color(0xFF26C6DA), name: "Salary" },{color:Color(0xFF26C6DA), name: "Salary" },];

  // List<Map<dynamic, Object>> incomeCategories = [
  //   {color: Color(0xFF26C6DA), name: "Salary"},
  //   {color: Color(0xFF26C6DA), name: "Salary"},
  // ];

  // final incomeCategories = <Object>[
  //   {color: Color(0xFF26C6DA), name: "Salary"},
  //   {color: Color(0xFF26C6DA), name: "Salary"},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackwardAppBar(title: 'Category Setting'),
      body: Column(
        children: const [
          TextDefine(categotyText: "Income", buttonText: "Clear All"),
          // incomeCategories.map(((e) {
          //   return CategoryBox(color: e.color, text: e.text);
          // })).toList(),

          // incomeCategories.forEach((e) {
          //   return CategoryBox(color: e.color, text: e.text);
          // }),

          CategoryBox(color: Color(0xFF26C6DA), text: "Salary"),
          CategoryBox(color: Color(0xFFEC407A), text: "Bonus"),
          CategoryBox(color: Color(0xFF795548), text: "Collect"),
          CategoryBox(color: Color(0xFFF6C008), text: "Interest"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NewCategory()));
        },
        backgroundColor: AppColors.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
