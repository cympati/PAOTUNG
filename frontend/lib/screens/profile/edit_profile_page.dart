import 'package:flutter/material.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'package:paotung_frontend/models/user.dart';
import 'package:paotung_frontend/screens/profile/profile_page.dart';
import 'package:paotung_frontend/utils/user_preferences.dart';
import 'package:paotung_frontend/widgets/common/app_bar.dart';
import 'package:paotung_frontend/widgets/common/button.dart';
import 'package:paotung_frontend/widgets/common/text_field.dart';
import 'package:paotung_frontend/widgets/main/profile/edit_profile_pic.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ Key? key }) : super(key: key);

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
              CustomAppBar(title: "Edit Profile"),
              //Picture
              ProfilePicEdit(imagePath: user.imagePath, onClicked: () async {},),
              SizedBox(height: 48,),
              //Input
              textInputField(title: "Email", obscure: false, text: user.email, onChanged: (value){}),
              textInputField(title: "Username", obscure: false, text: user.username, onChanged: (value){}),
              textInputField(title: "Password", obscure: true, text: "", onChanged: (value){}),
              textInputField(title: "Confirm Password", obscure: true, text: "", onChanged: (value){}),
              SizedBox(height: 60,),
              //Log out
              RoundedButton(
                text: "Save", 
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MyPage())));}, 
                  color: AppColors.mainColor, 
                  textColor: Colors.white
                )
            ],
          ),
    
        
      ),
    );
  }
}