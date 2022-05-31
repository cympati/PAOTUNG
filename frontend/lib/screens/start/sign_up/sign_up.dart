import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/account_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _registerBtnController =
      RoundedLoadingButtonController();
  bool checked = false;
  bool isSubmit = false;
  late TapGestureRecognizer _recognizer;

  final _emailKey = TextEditingController();
  final _usernameKey = TextEditingController();
  final _passwordKey = TextEditingController();
  final _confirmKey = TextEditingController();

  void _registerCall() async {
    if (_passwordKey.text == _confirmKey.text && _passwordKey.text.isNotEmpty && _confirmKey.text.isNotEmpty) {
      var register =
      await AccountService.register(_emailKey.text, _usernameKey.text, _passwordKey.text);
      if (register is ErrorStartResponse) {
        showAlertDialog(context, register.message);
        _registerBtnController.reset();
        _formkey.currentState!.reset();
      } else {
        _registerBtnController.success();
        _loginNavigate();
      }
    }

  }

  void _loginNavigate() async {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/mainpage');
    });
  }

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacementNamed(context, '/login');
      };
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
            children: [
              const SizedBox(
                height: 55,
              ),
              const AuthenTitle(
                  title: "Create Account",
                  description: "register PAOTUNG to be rich 🤑 "),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            controller: _emailKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(

                                fillColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.mainColor))),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Username"),
                          TextFormField(
                            autovalidateMode:  AutovalidateMode.onUserInteraction ,
                            controller: _usernameKey,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: AppColors.mainColor))),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Password"),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length< 8) {
                                return 'Your password length is incorrect';
                              }
                            },
                            autovalidateMode:  AutovalidateMode.onUserInteraction ,
                            controller: _passwordKey,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: AppColors.mainColor))),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text("Confirm Password"),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              } else if (_passwordKey.text !=
                                  _confirmKey.text) {
                                return 'Confirm password is not match';
                              }
                            },
                            controller: _confirmKey,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: AppColors.mainColor))),
                          ),

                          const SizedBox(
                            height: 57,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                    text: "Already have an account?  ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                                TextSpan(
                                    text: "Log in",
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
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            color: AppColors.mainColor,
                            borderRadius: 20,
                            controller: _registerBtnController,
                            onPressed: () {
                              setState(() {
                                isSubmit = true;
                              });
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                isSubmit = false;
                                _registerCall();
                              }
                              _registerBtnController.reset();
                            },
                          ),
                          SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  ))

            ],
          ),
        ),
      ],
    ));
  }
}
