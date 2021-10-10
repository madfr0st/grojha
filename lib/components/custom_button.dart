import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomButton {
  GestureTapCallback press;
  Color color1;
  Color color2;
  String name;
  double height;
  double width;
  double fontSize;

  CustomButton(
      {this.press,
      this.color1,
      this.color2,
      this.name,
      this.height,
      this.width,
      this.fontSize});

  Container button_1() {
    return Container(
      height: height,
      width: width,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     color1.withOpacity(1),
            //     color2.withOpacity(0.5),
            //   ],
            // ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Material(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: press,
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  //height: getProportionateScreenWidth(50),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ))),
      ),
    );
  }
}
