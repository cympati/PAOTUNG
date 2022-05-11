import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/services/account_service.dart';
import 'package:paotung_frontend/screens/start/login/login.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
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
  String? email;
  String? username;
  String? password;
  String? confirmpassword;
  bool isSubmit = false;
  late TapGestureRecognizer _recognizer;
  // final _emailKey = GlobalKey<FormState>();
  // final _usernameKey = GlobalKey<FormState>();
  // final _passwordKey = GlobalKey<FormState>();
  // final _confirmKey = GlobalKey<FormState>();

  // void _checkEmail() {}

  // void _checkUsername() {}

  // void _checkPassword() {}

  // void _checkConfirm() {}

  void _registerCall() async {
    //loginNavigate
    if (password != confirmpassword) {
      showAlertDialog(context, "Password not match");
    } else {
      var register = await AccountService.register(
          email!, username!, password!, confirmpassword!);
      if (register is ErrorResponse) {
        showAlertDialog(context, register.message);
        _registerBtnController.reset();
      } else {
        _registerBtnController.success();
        _loginNavigate();
      }
    }
  }

  void _loginNavigate() {
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
      body: Column(
        key: _formkey,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Signup Title
          SizedBox(
            height: 80,
          ),
          AuthenTitle(
              title: "Create Account",
              description: "register PAOTUNG to be rich 🤑 "),
          SizedBox(
            height: 20,
          ),
          //Input text
          textInputField(
            onSaved: (value) {
              email = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the email';
              }
              if (!EmailValidator.validate(value)) {
                return 'Emain is invalid';
              }
              return null;
            },
            // key: _formkey,
            title: "Email",
            obscure: false,
            text: '',
            onChanged: (value) {},
            // formKey: _emailKey
          ),
          textInputField(
            onSaved: (value) {
              username = value;
            },
            title: "Username",
            obscure: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the username';
              }
              return null;
            },
            text: '',
            onChanged: (value) {},
            // formKey: _usernameKey,
          ),
          textInputField(
            onSaved: (value) {
              password = value;
            },
            title: "Password",
            obscure: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the password';
              }
              if (value.length < 8) {
                return 'Password must have at leasr 8 character';
              }
              return null;
            },
            autovalidateMode: isSubmit
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            text: '',
            onChanged: (value) {},
            // formKey: _passwordKey,
          ),
          textInputField(
            onSaved: (value) {
              confirmpassword = value;
            },
            title: "Confirm Password",
            obscure: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the Confirm Password';
              }
              return null;
            },
            autovalidateMode: isSubmit
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            text: '',
            onChanged: (value) {},
            // formKey: _confirmKey,
          ),
          //Go to login page
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                const TextSpan(
                    text: "Already have an accout? ",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: "Log in",
                    style: TextStyle(color: AppColors.mainColor),
                    recognizer: _recognizer)
              ]),
            ),
          ),
          //Button
          RoundedLoadingButton(
            height: 70,
            width: 420,
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
          )
        ],
      ),
    );
  }
}
