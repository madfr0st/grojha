import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grojha/components/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  static const String _url =
      "https://play.google.com/store/apps/details?id=com.grojha.grojha";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        height: getProportionateScreenWidth(300),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: SizeConfig.screenWidth * .5,
              width: SizeConfig.screenWidth * .5,
              child: SvgPicture.asset(
                "assets/icons/sad_face.svg",
                color: kPrimaryColor,
              ),
            ),
            Text(
              "Please update your app.",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: DefaultButton(
                press: () => _launchURL(),
                text: "Update App",
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
