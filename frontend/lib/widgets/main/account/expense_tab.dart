import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/utils/extensions.dart';
import 'package:paotung_frontend/widgets/main/account/month_tab.dart';
import 'package:paotung_frontend/widgets/main/account/today_tab.dart';

enum Tab { today, month }

class TransactionsTab extends StatefulWidget {
  const TransactionsTab({ Key? key }) : super(key: key);

  @override
  State<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends State<TransactionsTab> {
  Tab currentTab = Tab.today;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 23,),
          child: Container(
            height: 40,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.lightgrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Tab.values
                  .map(
                    (e) => Expanded(
                      child: TabItem((e.name.titleCaseSingle()),
                          value: e,
                          groupValue: currentTab,
                          onChanged: (value) =>
                              setState(() => currentTab = value)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        IndexedStack(
          index: currentTab.index,
          children: const [TodayTab(), MonthTab()],
        ),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final Tab value;
  final Tab groupValue;
  final ValueChanged<Tab> onChanged;

  const TabItem(
    this.title, {
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainColor : AppColors.lightgrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    ).onTap(() => onChanged(value));
  }
}