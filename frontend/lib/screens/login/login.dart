import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/screens/main/dashboard/dashborad.dart';
import 'package:paotung_frontend/screens/signup/signup.dart';
import 'package:paotung_frontend/widgets/authentication/login.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/constants/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  void _checkEmail() {}

  void _checkPassword() {}

  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Login Title
          SizedBox(
            height: 80,
          ),
          AuthenTitle(
              title: "Login", description: "Welcome back to PAOTUNG!💰"),
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
            title: "Password",
            obscure: true,
            text: '',
            onChanged: (value) {},
            formKey: _passwordKey,
          ),
          //Go to signup page
          Spacer(),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
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
          RoundedButton(
              text: "Log in",
              onPressed: () {
                /*
              if(){

              }
              */
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              color: AppColors.mainColor,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
