import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../constants.dart';

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

  static Container bannerWithoutBackground(
      { String text,
         double fontSize,
         Color color,
         double fontHeight}) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: fontHeight,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Container heading(
      { String text,
         Color color,
      }) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          height: 1.2,
          fontWeight: FontWeight.bold,
          fontSize: getProportionateScreenWidth(20),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Container errorBanner(
      { String text}) {
    return Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error,color: Colors.red,),
            SizedBox(width: getProportionateScreenWidth(10),),
            Text(
              text,
              style: TextStyle(
                color: Colors.red,
                height: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
    );
  }

  static Container emptyStatusBanner(
      { String text}) {
    return Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sentiment_very_dissatisfied,color: kPrimaryColor),
            SizedBox(width: getProportionateScreenWidth(10),),
            Text(
              text,
              style: TextStyle(
                color: kPrimaryColor,
                height: 1.2,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
    );
  }

}
