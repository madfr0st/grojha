import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

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
              ],
            ),
          ),
        ));
  }
}
