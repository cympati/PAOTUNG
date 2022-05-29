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
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
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
                            autovalidateMode:  AutovalidateMode.onUserInteraction , // turn on automatic verification
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
                          //Save
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

// Form(
//   key: _formkey,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       //Signup Title
//       const SizedBox(
//         height: 80,
//       ),
//       const AuthenTitle(
//           title: "Create Account",
//           description: "register PAOTUNG to be rich 🤑 "),
//       const SizedBox(
//         height: 20,
//       ),
//       //Input text
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//         child: TextFormField(
//           decoration: InputDecoration(labelText: 'Email'),
//           onSaved: (value) {
//             email = value;
//           },
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please fill the email';
//             }
//             if (!EmailValidator.validate(value)) {
//               return 'Email is invalid';
//             }
//             return null;
//           },
//           autovalidateMode: isSubmit
//               ? AutovalidateMode.onUserInteraction
//               : AutovalidateMode.disabled,
//           // key: _formkey,
//           // title: "Email",
//           // obscure: false,
//           // text: '',
//           onChanged: (value) {},
//           // formKey: _emailKey
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//         child: TextFormField(
//           onSaved: (value) {
//             username = value;
//           },
//           decoration: InputDecoration(labelText: 'Username'),
//           // title: "Username",
//           // obscure: false,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter the username';
//             }
//             return null;
//           },
//           // autovalidateMode: isSubmit
//           //     ? AutovalidateMode.onUserInteraction
//           //     : AutovalidateMode.disabled,
//           // text: '',
//           onChanged: (value) {},
//           // formKey: _usernameKey,
//         ),
//       ),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//         child: TextFormField(
//           decoration: InputDecoration(labelText: 'Password'),
//           onSaved: (value) {
//             password = value;
//           },
//           // title: "Password",
//           obscureText: true,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter the password';
//             }
//             if (value.length < 8) {
//               return 'Password must have at leasr 8 character';
//             }
//             return null;
//           },
//           autovalidateMode: isSubmit
//               ? AutovalidateMode.onUserInteraction
//               : AutovalidateMode.disabled,
//           // text: '',
//           onChanged: (value) {},
//           // formKey: _passwordKey,
//         ),
//       ),
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//         child: TextFormField(
//           decoration: InputDecoration(labelText: 'Confirm password'),
//           onSaved: (value) {
//             confirmpassword = value;
//           },
//           // title: "Confirm Password",
//           obscureText: true,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Please enter the Confirm Password';
//             }
//             return null;
//           },
//           autovalidateMode: isSubmit
//               ? AutovalidateMode.onUserInteraction
//               : AutovalidateMode.disabled,
//           // text: '',
//           onChanged: (value) {},
//           // formKey: _confirmKey,
//         ),
//       ),
//       //Go to login page
//       const Spacer(),
//       Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.only(bottom: 20),
//         child: RichText(
//           text: TextSpan(children: <TextSpan>[
//             const TextSpan(
//                 text: "Already have an accout? ",
//                 style: TextStyle(color: Colors.grey)),
//             TextSpan(
//                 text: "Log in",
//                 style: TextStyle(color: AppColors.mainColor),
//                 recognizer: _recognizer)
//           ]),
//         ),
//       ),
//       //Button
//       RoundedLoadingBtn(
//         text: 'Create Account',
//         bottom: 40,
//         controller: _registerBtnController,
//         onPressed: () {
//           setState(() {
//             isSubmit = true;
//           });
//           if (_formkey.currentState!.validate()) {
//             _formkey.currentState!.save();
//             isSubmit = false;
//             _registerCall();
//           }
//           _registerBtnController.reset();
//         },
//       )
//       // RoundedLoadingButton(
//       //   height: 70,
//       //   width: 420,
//       //   child: const Text(
//       //     'Create Account',
//       //     style: TextStyle(
//       //       fontSize: 16,
//       //       color: Colors.white,
//       //     ),
//       //   ),
//       //   color: AppColors.mainColor,
//       //   borderRadius: 20,
//       //   controller: _registerBtnController,
//       //   onPressed: () {
//       //     setState(() {
//       //       isSubmit = true;
//       //     });
//       //     if (_formkey.currentState!.validate()) {
//       //       _formkey.currentState!.save();
//       //       isSubmit = false;
//       //       _registerCall();
//       //     }
//       //     _registerBtnController.reset();
//       //   },
//       // )
//     ],
//   ),
// ),
