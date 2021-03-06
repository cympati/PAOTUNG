import 'package:flutter/material.dart' as material;
import 'package:paotung_frontend/screens/main/account/presentation/add_transaction.dart';
// import 'package:paotung_frontend/screens/main/account/presentation/show_transaction.dart';
import 'package:paotung_frontend/screens/main/profile/new_category.dart';
import 'package:paotung_frontend/screens/main/profile/category_setting.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/screens/help_center/help_center.dart';
import 'package:paotung_frontend/screens/splashscreen/splash.dart';
import 'package:paotung_frontend/screens/start/login/login.dart';
import 'package:paotung_frontend/screens/welcome/onboarding.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';

import '../screens/main/profile/profile_page.dart';
import '../screens/start/sign_up/sign_up.dart';

class RouteConstant {
  static Map<String, material.WidgetBuilder> route() {
    return <String, material.WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/welcome': (_) => Onboarding(),
      '/register': (_) => const SignUpScreen(),
      '/mainpage': (_) => const MainPage(),
      '/categorysetting': (_) => const CategorySetting(),
      '/newcategory': (_) => const NewCategory(readJson: null,),
      // '/addtransaction': (_) =>  AddTransaction(),
      '/helpcenter': (_) => HelpCenter(),
      '/notisetting': (_) => const NotificationSetting(),
      // '/showtransaction': (_) => const ShowTransaction(),
      '/login': (_) => const LoginScreen(),
      '/profile': (_) => const MyPage(),
    };
  }
}
