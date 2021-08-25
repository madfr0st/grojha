import 'package:flutter/material.dart';
import 'package:grojha/screens/complete_profile/complete_profile_screen.dart';
import 'package:grojha/screens/notification/notification_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: "Update Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, CompleteProfileScreen.routeName)
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
