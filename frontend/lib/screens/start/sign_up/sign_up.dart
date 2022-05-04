import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/start/login/login.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/constants/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormState>();

  void _checkEmail() {}

  void _checkUsername() {}

  void _checkPassword() {}

  void _checkConfirm() {}

  late TapGestureRecognizer _recognizer;

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
              title: "Email",
              obscure: false,
              text: '',
              onChanged: (value) {},
              formKey: _emailKey),
          textInputField(
            title: "Username",
            obscure: false,
            text: '',
            onChanged: (value) {},
            formKey: _usernameKey,
          ),
          textInputField(
            title: "Password",
            obscure: true,
            text: '',
            onChanged: (value) {},
            formKey: _passwordKey,
          ),
          textInputField(
            title: "Confirm Password",
            obscure: true,
            text: '',
            onChanged: (value) {},
            formKey: _confirmKey,
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
          RoundedButton(
              text: "Create Account",
              bottom: 60,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/mainpage');
              },
              color: AppColors.mainColor,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
