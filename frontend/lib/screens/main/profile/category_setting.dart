// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/categories.dart';
import 'package:paotung_frontend/screens/main/profile/newcategory.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/custom_app_bar.dart';

class CategorySetting extends StatefulWidget {
  final List<Categories> categories;
  const CategorySetting({Key? key, required this.categories}) : super(key: key);

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CloseAppBar(title: 'Category Setting'),
      body: Column(
        children: [
          TextDefine(categotyText: "Income", buttonText: "Clear All"),
          widget.categories.mapIndexed((index, category) => CategoryBox(color: category.color, name: category.name)).toList(),
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
