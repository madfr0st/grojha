import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/components/grad_button.dart';

import '../../../size_config.dart';
import 'dart:io';

import '../complete_profile_screen.dart';

class Header extends StatefulWidget {
  const Header({Key key, this.appUser}) : super(key: key);

  final AppUser appUser;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: getProportionateScreenWidth(200),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      //color: Colors.greenAccent,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: getProportionateScreenWidth(150),
                height: getProportionateScreenWidth(150),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: CompleteProfileScreen.userImage,
              )),
          SizedBox(
            width: getProportionateScreenWidth(20),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GradButton(
                  name: "Open Camera",
                  color1: Colors.greenAccent,
                  color2: Colors.lightBlue,
                  press: _getFromCamera,
                ),
                GradButton(
                  name: "Open Galary",
                  color1: Colors.redAccent,
                  color2: Colors.pinkAccent,
                  press: _getFromGallery,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File cropImage = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          maxWidth: 500,
          maxHeight: 500,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
      setState(() {
        CompleteProfileScreen.userImageFile = cropImage;
        CompleteProfileScreen.userImage =
            Image.file(cropImage, fit: BoxFit.fill);
      });
    }
  }

  // Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File cropImage = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          maxWidth: 500,
          maxHeight: 500,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
      setState(() {
        CompleteProfileScreen.userImageFile = cropImage;
        CompleteProfileScreen.userImage =
            Image.file(cropImage, fit: BoxFit.fill);
      });
    }
  }
// _getFromGallery() async {
//   PickedFile pickedFile = await ImagePicker().getImage(
//     source: ImageSource.gallery,
//     maxWidth: 1800,
//     maxHeight: 1800,
//   );
//   _cropImage(pickedFile.path);
// }
//
// /// Crop Image
// _cropImage(filePath) async {
//   File croppedImage = await ImageCropper.cropImage(
//     sourcePath: filePath,
//     maxWidth: 1080,
//     maxHeight: 1080,
//   );
// }
}
