import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/screens/main/mainpage.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/common/backward_app_bar.dart';
import 'package:paotung_frontend/widgets/common/rounded_button.dart';
import 'package:paotung_frontend/widgets/common/text_input_field.dart';
import 'package:paotung_frontend/widgets/main/profile/edit_profile_pic.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            //App bar
            BackwardAppBar(title: "Edit Profile"),
            Container(
              height: 40,
            ),
            //Picture
            EditProfilePic(
              imagePath: user.imagePath,
            ),
            SizedBox(
              height: 48,
            ),
            //Input
            textInputField(
                title: "Email",
                obscure: false,
                text: user.email,
                onChanged: (value) {}),
            textInputField(
                title: "Username",
                obscure: false,
                text: user.username,
                onChanged: (value) {}),
            textInputField(
                title: "Password",
                obscure: true,
                text: "",
                onChanged: (value) {}),
            textInputField(
                title: "Confirm Password",
                obscure: true,
                text: "",
                onChanged: (value) {}),
            SizedBox(
              height: 50,
            ),
            //Log out
            RoundedButton(
              text: "Save",
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.mainColor,
              textColor: Colors.white,
              bottom: 0,
            ),
            Container(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
