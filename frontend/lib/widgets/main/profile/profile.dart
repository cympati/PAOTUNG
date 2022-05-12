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

  //reload page after Pop edit profile page
  _navigate(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfilePage()));
        if (result){
          setState(() {
            
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 40.0,
              backgroundColor: AppColors.lightgrey,
              backgroundImage: user.imagePath.isEmpty ?  NetworkImage(user.imagePath) : NetworkImage(user.imagePath),
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
