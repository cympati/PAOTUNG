import 'package:flutter/material.dart';
import 'package:paotung_frontend/models/user.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/common/app_bar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ Key? key }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            CustomAppBar(title: "Edit Profile"),

          ],
        ),

      
    );
  }
}