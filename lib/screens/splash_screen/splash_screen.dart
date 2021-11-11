import 'package:flutter/material.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/instructions.dart';
import 'package:grojha/screens/login_screen/login_screen.dart';

import '../../size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            "assets/images/splash.png",
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenHeight,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(100),
                ),
                Image.asset(
                  "assets/images/grojhalogo big.png",
                  height: getProportionateScreenWidth(120),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Instructions.bannerWithoutBackground(
                    text: "Welcome to Grojha. Let's shop!",
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.black,
                    fontHeight: 1.2),
                const Spacer(),
                DefaultButton(text: "Continue", press: () {
                  print("check");
                  Navigator.pushNamed(context, LoginScreen.routeName);
                }),
                SizedBox(
                  height: getProportionateScreenWidth(50),
                ),
                Instructions.bannerWithoutBackground(
                    text:
                        "Pressing continue means you accept our terms and condition.",
                    fontSize: getProportionateScreenWidth(12),
                    color: Colors.black54,
                    fontHeight: 1.2),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
