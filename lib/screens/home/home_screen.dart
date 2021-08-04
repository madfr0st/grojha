import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/components/coustom_bottom_nav_bar.dart';
import 'package:grojha/enums.dart';
import 'package:grojha/screens/home/components/home_header.dart';
import 'package:grojha/size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
