import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/main/profile/edit_profile_pic.dart';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RoundedLoadingButtonController _editBtnController =
      RoundedLoadingButtonController();

  String tempEmail = '';
  String tempUsername = '';

  bool isSubmit = false;

  User _user = User(email: "", username: "", imagePath: "", balance: 0);
  User nulluser = UserPreferences.myUser;

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  void initState() {
    _readJson();
    super.initState();
  }

  Future<void> _readJson() async {
    var responseUser = await GetUser.getData();
    if (mounted) {
      setState(() {
        _user = responseUser;
      });
    }
  }

  void getImage({required ImageSource source}) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 70);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _editNavigate() {
      Timer(const Duration(milliseconds: 1500), () {
        Navigator.pop(context, true);
      });
    }

    void _editCall() async {
      print(tempEmail);
      print(tempUsername);
      print(_passwordController.text);
      if (tempEmail.isNotEmpty &&
          tempUsername.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text) {
        var updateProfile = await GetUser.updateProfile(
            tempEmail, tempUsername, _passwordController.text);
            print("email: " + tempEmail );
            print("username: " + tempUsername );
        if (updateProfile is ErrorResponse) {
          showAlertDialog(context, updateProfile.message);
          _editBtnController.reset();
        } else {
          _editBtnController.success();
          _editNavigate();
        }
      } else {
        _editBtnController.reset();
      }
    }

    return Scaffold(
      appBar: BackwardAppBar(title: "Edit Profile"),
      body: Form(
        key: _formkey,
        child: Container(
          child: ListView(
            children: [
              Container(
                height: 40,
              ),
              //Picture
              EditProfilePic(
                imagePath: _imageFile == null
                    ? _user.imagePath
                    : FileImage(File(_imageFile!.path)).toString(),
                onTaped: () {
                  getImage(source: ImageSource.gallery);
                },
              ),
              SizedBox(
                height: 48,
              ),
              //Input
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email"),
                    TextFormField(
                      controller: TextEditingController(text: _user.email),
                      onSaved: (text) => setState(() {
                        tempEmail = text!;
                      }),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Username"),
                    TextFormField(
                      controller: TextEditingController(text: _user.username),
                      onSaved: (text) => setState(() {
                        tempUsername = text!;
                      }),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Password"),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Confirm Password"),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.mainColor))),
                    ),
                  ],
                ),
              ),
              // textInputField(
              //   title: "Email",
              //   obscure: false,
              //   text: _user.email,
              //   onChanged: (text) => setState(() {
              //     tempEmail = text;
              //     print(tempEmail);
              //   }),
              // ),
              // textInputField(
              //   title: "Username",
              //   obscure: false,
              //   text: _user.username,
              //   onChanged: (value) => setState(() {
              //     tempUsername = value;
              //   }),
              // ),
              // textInputField(
              //   //controller: _passwordController,
              //   title: "Password",
              //   obscure: true,
              //   text: "",
              //   onChanged: (value) => setState(() {
              //     tempEmail = value;
              //   }),
              // ),
              // textInputField(
              //   //controller: _confirmPasswordController,
              //   title: "Confirm Password",
              //   obscure: true,
              //   text: "",
              //   onChanged: (value) => setState(() {
              //     tempEmail = value;
              //   }),
              // ),
              SizedBox(
                height: 50,
              ),
              //Save
              RoundedLoadingBtn(
                text: 'Save',
                bottom: 40,
                controller: _editBtnController,
                onPressed: () {
                  setState(() {
                    isSubmit = true;
                  });
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isSubmit = false;
                    _editCall();
                  }
                  _editBtnController.reset();
                },
              ),
              // RoundedButton(
              //   text: "Save",
              //   onPressed: () {
              //     Navigator.pop(context, true);
              //   },
              //   color: AppColors.mainColor,
              //   textColor: Colors.white,
              //   bottom: 0,
              // ),
              Container(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
