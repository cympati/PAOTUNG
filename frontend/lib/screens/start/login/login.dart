import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/account_service.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/screens/main/dashboard/dashborad.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/screens/start/sign_up/sign_up.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _emailKey = GlobalKey<FormState>();
  // final _passwordKey = GlobalKey<FormState>();
  // void _checkEmail() {}
  // void _checkPassword() {}
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    getSharedPreference();
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.popAndPushNamed(context, '/register');
      };
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final RoundedLoadingButtonController _loginBtnController =
      RoundedLoadingButtonController();
  String errorText = "";
  late SharedPreferences prefs;

  getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
  }

  void _logincall() async {
    if (_emailController.value.text.isEmpty ||
        _passwordController.value.text.isEmpty) {
      setState(() {
        errorText = 'Email or password is empty';
      });
    }
    var login = await AccountService.login(
        _emailController.text, _passwordController.text);
    if (login is ErrorResponse) {
      setState(() {
        errorText = login.message;
      });
      _loginBtnController.reset();
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   getSharedPreference();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Login Title
          const SizedBox(
            height: 80,
          ),
          const AuthenTitle(
              title: "Login", description: "Welcome back to PAOTUNG!💰"),
          const SizedBox(
            height: 20,
          ),
          //Input text
          ValueListenableBuilder(
              valueListenable: _passwordController,
              builder: (context, TextEditingValue value, __) {
                return Column(
                  children: [
                    textInputField(
                      controller: _emailController,
                      title: "Email",
                      obscure: false,
                      text: '',
                      onChanged: (_) => setState(() {
                        errorText = '';
                      }),
                      // formKey: _emailKey
                    ),
                    textInputField(
                      controller: _passwordController,
                      title: "Password",
                      obscure: true,
                      text: '',
                      onChanged: (_) => setState(() {
                        errorText = '';
                      }),
                      // formKey: _passwordKey,
                    ),
                    errorText.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              errorText,
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : Container(),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12, top: 10),
                      child: Text(
                        '',
                        textAlign: TextAlign.end,
                      ),
                    ),
                    //Go to signup page
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: "New Here? Create an account ",
                              style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: "Sign Up",
                              style: TextStyle(color: AppColors.mainColor),
                              recognizer: _recognizer)
                        ]),
                      ),
                    ),
                    //Button
                    Container(
                      margin: EdgeInsets.only(bottom: 60),
                      child: RoundedLoadingButton(
                        height: 70,
                        width: 420,
                        child: Text(
                          'log in',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        color: AppColors.mainColor,
                        borderRadius: 12,
                        controller: _loginBtnController,
                        onPressed: _passwordController.value.text.isNotEmpty &&
                                _emailController.value.text.isNotEmpty
                            ? _logincall
                            : null,
                        disabledColor: AppColors.mainColor,
                      ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }
}
