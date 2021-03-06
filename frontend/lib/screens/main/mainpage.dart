
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/main/account/account_page.dart';
import 'package:paotung_frontend/screens/main/dashboard/dashborad.dart';
import 'package:paotung_frontend/screens/main/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    AccountPage(),
    Dashboard(),
    MyPage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.grey.withOpacity(0.8),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              label: "Account",
              icon: Icon(
                Icons.account_balance_wallet_rounded,
                size: 24,
              ),
            ),
            BottomNavigationBarItem(
              label: "Dashboard",
              icon: Icon(
                Icons.show_chart,
                size: 24,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.account_circle_outlined,
                size: 24,
              ),
            ),
          ]),
    );
  }
}
