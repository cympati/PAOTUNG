import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/screens/welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState() {
    async.Timer(const Duration(milliseconds: 2000),  () async {
      final prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');
      if(user == null){
        Navigator.pushReplacementNamed(context, '/welcome');
      }
      else{
        Navigator.pushReplacementNamed(context, '/mainpage');
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: const Center(
          child: Text(
        "PAOTUNG",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
      )),
    );
  }
}
