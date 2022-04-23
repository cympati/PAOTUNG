import 'package:flutter/material.dart' as material;
import 'package:paotung_frontend/screens/splashscreen/splash.dart';
import 'package:paotung_frontend/screens/welcome/onboarding.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';

class RouteConstant {
  static Map<String, material.WidgetBuilder> route() {
    return <String, material.WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/welcome': (_) => Onboarding(),
      '/mainpage': (_) => MainPage(),
    };
  }
}
