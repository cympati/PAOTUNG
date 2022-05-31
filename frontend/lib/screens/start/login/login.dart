import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/account_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer _recognizer;
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RoundedLoadingButtonController _loginBtnController =
      RoundedLoadingButtonController();
  String errorText = "";
  late SharedPreferences prefs;
  bool isSubmit = false;

  @override
  void initState() {
    getSharedPreference();
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.popAndPushNamed(context, '/register');
      };
  }

  getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
  }

  void _logincall() async {
    var login = await AccountService.login(
        _emailController.text, _passwordController.text);
    if (login is ErrorStartResponse) {
      showAlertDialog(context, login.message);
      _loginBtnController.reset();
      _formkey.currentState!.reset();
    } else {
      _loginBtnController.success();
      _loginNavigate();
    }
  }

  void _loginNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/mainpage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              const AuthenTitle(
                  title: "Login", description: "Welcome back to PAOTUNG!💰"),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formkey,
                child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 53, top: 40),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.MedGrey),
                            ),
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.MedGrey),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 8) {
                                  return 'Your password length is incorrect';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                            ),
                            const SizedBox(
                              height: 207,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  const TextSpan(
                                      text: "New Here? Create an account  ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                  TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 16),
                                      recognizer: _recognizer)
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            RoundedLoadingButton(
                              height: 70,
                              child: const Text(
                                'log in',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              color: AppColors.mainColor,
                              borderRadius: 20,
                              controller: _loginBtnController,
                              onPressed: () {
                                setState(() {
                                  isSubmit = true;
                                });
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  isSubmit = false;
                                  _logincall();
                                }
                                _loginBtnController.reset();
                              },
                            ),
                            SizedBox(height: 40,)
                          ]),
                    )),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
