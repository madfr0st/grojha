import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  static Image userImage = Image.asset("assets/images/default.jpg");
  //static String userName = "Select shop category";
  static File userImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
