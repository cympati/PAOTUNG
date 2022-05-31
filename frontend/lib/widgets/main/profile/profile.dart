// import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:paotung_frontend/core/data/services/user_service.dart';
import 'package:paotung_frontend/screens/main/profile/edit_profile_page.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';

class profileSection extends StatefulWidget {
  Function readJson;
  User user;
   profileSection({Key? key, required this.readJson, required this.user}) : super(key: key);

  @override
  State<profileSection> createState() => _profileSectionState();
}

class _profileSectionState extends State<profileSection> {

  User nullUser = UserPreferences.myUser;

  @override
  void initState() {
    super.initState();
    widget.readJson();

  }

  @override
  Widget build(BuildContext context) {
    //reload page after Pop edit profile page
    _navigate(BuildContext context) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePage(
                    readJson: widget.readJson,
                    userInfo: widget.user,
                  ))).then((_) => setState(() {}));
    }


    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 40.0,
              backgroundColor: AppColors.lightgrey,
              backgroundImage: widget.user.imagePath.isEmpty
                  ? NetworkImage(nullUser.imagePath)
                  : FileImage(File(
                          '/data/user/0/com.example.paotung_frontend/cache/${widget.user.imagePath}'))
                      as ImageProvider<Object>,
            ),
            // FileImage(File('/data/user/0/com.example.paotung_frontend/cache/${_user.imagePath}')) as ImageProvider<Object>
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.username,
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
                      _navigate(context);
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
