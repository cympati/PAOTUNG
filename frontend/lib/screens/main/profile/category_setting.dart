
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/category/categories.dart';
import 'package:paotung_frontend/core/data/services/category_income_service.dart';
import 'package:paotung_frontend/screens/main/profile/new_category.dart';
import 'package:paotung_frontend/widgets/category/category_box.dart';
import 'package:paotung_frontend/widgets/category/text_define.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
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
    super.initState();
    _readJson();
  }

  Future<void> _readJson() async {
    var responseCategoriesExpense = await GetCategoryExpenseService.getData();
    var responseCategoriesIncome = await GetCategoryIncomeService.getData();
    if (mounted) {
      setState(() {
        _categoriesExpense = responseCategoriesExpense;
        _categoriesIncome = responseCategoriesIncome;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const BackwardAppBar(title: "Category Setting",),
          TextDefine(text: "Income", buttonText: "Clear All", isNotification:false,readJson:_readJson, transactionType: "income"),
          Container(

            height: 5,
          ),
          Padding(
              padding: EdgeInsets.all(0),
              child: _categoriesIncome.isEmpty
                  ? DefaultText(text: 'category',color:true)
                  : Column(children: [
                      ..._categoriesIncome.map((category) {
                        return CategoryBox(
                            color: category.color, name: category.name, categoryId: category.id,readJson: _readJson,);
                      }).toList(),
                      Container(
                        height: 10,
                      ),
                    ])),
           TextDefine(text: "Expense", buttonText: "Clear All", isNotification:false,readJson:_readJson,transactionType:"expense"),
          Container(
            height: 10,
          ),

          Padding(
              padding: EdgeInsets.all(0),
              child: _categoriesExpense.isEmpty
                  ? const DefaultText(text: 'category',color:true)
                  : Column(children: [
                      ..._categoriesExpense.map((category) {
                        return CategoryBox(
                            color: category.color, name: category.name, categoryId: category.id, readJson: _readJson,);
                      }).toList(),
                      Container(
                        height: 60,
                      ),
                    ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewCategory(readJson: _readJson)));
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
