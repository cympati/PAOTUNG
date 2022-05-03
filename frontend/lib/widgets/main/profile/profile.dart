import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/screens/main/profile/edit_profile_page.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';

class profileSection extends StatefulWidget {
  const profileSection({Key? key}) : super(key: key);

  @override
  State<profileSection> createState() => _profileSectionState();
}

class _profileSectionState extends State<profileSection> {
  User user = UserPreferences.myUser;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 40.0,
          backgroundColor: AppColors.lightgrey,
          backgroundImage: NetworkImage(user.imagePath),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.username,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()));
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                )),
          ],
        ),
      ],
    ));
  }
}
