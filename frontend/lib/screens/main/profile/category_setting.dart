// import 'dart:ffi';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/categories.dart';
import 'package:paotung_frontend/core/data/services/category_income_service.dart';
import 'package:paotung_frontend/screens/main/profile/new_category.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/close_app_bar.dart';
import 'package:paotung_frontend/widgets/common/default_text.dart';

import '../../../core/data/services/category_expense_service.dart';
import '../../../widgets/common/backward_app_bar.dart';

class CategorySetting extends StatefulWidget {
  const CategorySetting({Key? key}) : super(key: key);

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

class _CategorySettingState extends State<CategorySetting> {
  List<Categories> _categoriesExpense = [];
  List<Categories> _categoriesIncome = [];

  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseCategoriesExpense = await GetCategoryExpenseService.getData();
    //var responseCategoriesIncome = await GetCategoryIncomeService.getData();
    inspect(responseCategoriesExpense);
    if (mounted) {
      setState(() {
        _categoriesExpense = responseCategoriesExpense;
        //_categoriesIncome = GetCategoryIncomeService.getCategories(responseCategoriesIncome);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CloseAppBar(title: 'Category Setting'),
      body: ListView(
        children: [
          const BackwardAppBar(title: "Category Setting"),
          const TextDefine(categotyText: "Income", buttonText: "Clear All"),
          Container(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: _categoriesIncome.isEmpty ? 
            DefaultText(text: 'category') :
            Column(
              children: [
                ..._categoriesIncome.map(( category) {
                  return CategoryBox(color: category.color, name: category.name);
                }).toList(),
                Container(
                  height: 30,
                ),
              ]
            )
          ),
          // const Spacer(),
          const TextDefine(categotyText: "Expense", buttonText: "Clear All"),
          Container(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.all(0),
            child: _categoriesExpense.isEmpty ? 
            DefaultText(text: 'category') :
            Column(
              children: [
                ..._categoriesExpense.map(( category) {
                  return CategoryBox(color: category.color, name: category.name);
                }).toList(),
                Container(
                  height: 60,
                ),
              ]
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => NewCategory()));
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
