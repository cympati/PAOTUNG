import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/screens/start/sign_up/alertdialog.dart';
import 'package:paotung_frontend/screens/main/profile/profile_page.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/roundloadingbtn.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/main/profile/edit_profile_pic.dart';
import 'package:path/path.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfilePage extends StatefulWidget {
  final Function readJson;
  final User userInfo;

  const EditProfilePage(
      {Key? key, required this.readJson, required this.userInfo})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RoundedLoadingButtonController _editBtnController =
      RoundedLoadingButtonController();
  bool isSubmit = false;
  User _user = User(email: "", username: "", imagePath: "", balance: 0);
  User nullUser = UserPreferences.myUser;

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  void initState() {
    widget.readJson();
    if (mounted) {
      setState(() {
        _user = widget.userInfo;
        print(_user.username);
      });
    }
    _emailController.text = _user.email;
    _usernameController.text  = _user.username;
    super.initState();
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
      Timer(const Duration(milliseconds: 1000), () {
        widget.readJson();
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    void _editCall() async {
      if (_passwordController.text == _confirmPasswordController.text && _passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
        var updateProfile = await GetUser.updateProfile(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text);
        if (updateProfile is ErrorResponse) {
          showAlertDialog(context, updateProfile.message);
          _editBtnController.reset();
          _formkey.currentState!.reset();
        } else {
          _editBtnController.success();
          _editNavigate();
        }
      }
    }

    return Scaffold(
      appBar: const BackwardAppBar(title: "Edit Profile"),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Container(
              height: 40,
            ),
            //Picture
            EditProfilePic(
              imagePath: _imageFile == null
                  ? nullUser.imagePath
                  : FileImage(File(_imageFile!.path)).toString(),
              onTaped: () {
                getImage(source: ImageSource.gallery);
              },
            ),
            const SizedBox(
              height: 48,
            ),
            //Input
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email"),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                    },
                    autovalidateMode:  AutovalidateMode.onUserInteraction , // turn on automatic verification
                    controller: _emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.mainColor))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Username"),
                  TextFormField(
                    autovalidateMode:  AutovalidateMode.onUserInteraction , // turn on automatic verification
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.mainColor))),
                  ),
                  const SizedBox(
                    height: 15,
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.mainColor))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Confirm Password"),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      } else if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return 'Confirm password is not match';
                      }
                    },
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
            const SizedBox(
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
                  _editCall();
                  isSubmit = false;
                }
                _editBtnController.reset();
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
