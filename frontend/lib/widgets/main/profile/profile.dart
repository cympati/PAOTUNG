//
import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';

class profileSection extends StatefulWidget {
  const profileSection({Key? key}) : super(key: key);

  @override
  State<profileSection> createState() => _profileSectionState();
}

class _profileSectionState extends State<profileSection> {
  String username = "Barbie Roberts";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 40.0,
          child: const Text('user'),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16,),
            Text("Edit Profile",style: TextStyle(color: AppColors.grey),),
          ],
        ),
      ],
    ));
  }
}
