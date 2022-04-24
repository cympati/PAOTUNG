import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/screens/login/login.dart';
import 'package:paotung_frontend/screens/main/dashborad.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/constants/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()..onTap = (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Signup Title
          SizedBox(height: 80,),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "Create Account",
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
              "register PAOTUNG to be rich 🤑 ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ), 
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 20,),
          //input text
          textInputField(title: "Email",  obscure: false ),
          textInputField(title: "Username",  obscure: false ),
          textInputField(title: "Password",  obscure: true ),
          textInputField(title: "Confirm Password", obscure: true ),
          //Go to login page
          Spacer(),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "Already have an accout? ", style: TextStyle(color: Colors.grey)),
                  TextSpan(text: "Log in", style: TextStyle(color: AppColors.mainColor), recognizer: _recognizer)
                ]
              ),

            ),
          ),
          //Button
          RoundedButton(
            text: "Create Account", 
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
              }, 
            color: AppColors.mainColor, 
            textColor: Colors.white)
        ],
      ),
    );
  }
}