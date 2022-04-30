import 'package:flutter/material.dart' as material;
import 'package:paotung_frontend/screens/main/account/presentation/add_transaction.dart';
import 'package:paotung_frontend/screens/main/profile/newcategory.dart';
import 'package:paotung_frontend/screens/main/profile/categorysetting.dart';
import 'package:paotung_frontend/screens/main/profile/notification_setting.dart';
import 'package:paotung_frontend/screens/profile/help_center.dart';
import 'package:paotung_frontend/screens/splashscreen/splash.dart';
import 'package:paotung_frontend/screens/welcome/onboarding.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';

class RouteConstant {
  static Map<String, material.WidgetBuilder> route() {
    return <String, material.WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/welcome': (_) => Onboarding(),
      '/mainpage': (_) => const MainPage(),
      '/categorysetting': (_) => const CategorySetting(),
      '/newcategory': (_) => const NewCategory(),
      '/helpcenter': (_) => const HelpCenter(),
      '/addtransaction': (_) => const AddTransaction(),
      '/helpcenter': (_) => const HelpCenter(),
      '/notisetting': (_) => const NotificationSetting(),
    };
  }
}
