import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/main/dashborad.dart';
import 'package:paotung_frontend/screens/signup/signup.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/constants/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Title
          Spacer(flex: 2,),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ), 
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "Welcome back to PAOTUNG!💰",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ), 
              textAlign: TextAlign.left,
            ),
          ),
          //input text
          Spacer(),
          textInputFeild(title: "Email", onChange: (value){}, obscure: false, ),
          textInputFeild(title: "Password", onChange: (value){}, obscure: true ),
          //Go to signup page
          Spacer(flex: 8,),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "New Here? Create an account ", style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "Sign Up", style: TextStyle(color: AppColors.mainColor), recognizer: _recognizer)
                ]
              ),

            ),
          ),
          //Button
          RoundedButton(
            text: "Log in", 
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
              }, 
            color: AppColors.mainColor, 
            textColor: Colors.white)
        ],
      ),
    );
  }
}