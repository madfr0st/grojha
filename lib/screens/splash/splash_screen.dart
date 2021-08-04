import 'package:flutter/material.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/splash/components/body.dart';
import 'package:grojha/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
