import 'dart:math';

import 'package:flutter/material.dart';

import 'package:grojha/size_config.dart';

import 'package:grojha/constants.dart';

class MenuTitle extends StatelessWidget {
  final GestureTapCallback press;
  final String title;
  final Color color;

  const MenuTitle({
    Key key,
    this.press,
    this.title, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
