import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paotung_frontend/constants/theme.dart';
import 'dart:io';

class EditProfilePic extends StatefulWidget {
  final String imagePath;

  const EditProfilePic({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

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
          image: _imageFile == null ? image : FileImage(File(_imageFile!.path)) as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {
            getImage(source: ImageSource.gallery);
          }),
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

  void getImage({required ImageSource source}) async {
    final pickedFile = await _picker.getImage(source: source,imageQuality: 70);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
