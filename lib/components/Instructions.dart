import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Instructions {
  static Container banner(String string,Color color) {
    return Container(
      //height: getProportionateScreenWidth(40),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(8)),
          color: Colors.white),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(6)),
        ),
        alignment: Alignment.center,
        child: Text(
          string,
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(16),
              height: 1.2
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Container banner_1(String text,Color color) {
    return Container(
      //height: getProportionateScreenWidth(40),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(6)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(16),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Container banner_2(String text,Color color,double fontSize, double margin) {
    return Container(
      //height: getProportionateScreenWidth(40),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(margin)),
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
          // color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(6)),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(fontSize),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
