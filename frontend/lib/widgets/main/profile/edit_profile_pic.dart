import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'dart:io';

class EditProfilePic extends StatefulWidget {
  final String imagePath;
  final void Function()? onTaped;

  const EditProfilePic({
    Key? key,
    required this.imagePath, this.onTaped,
  }) : super(key: key);

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(AppColors.mainColor),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(widget.imagePath);

    return ClipOval(
      child: Material(
        color: AppColors.lightgrey,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: widget.onTaped),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) => ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  
}
