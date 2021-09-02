import 'package:flutter/material.dart';
import 'package:grojha/constants.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                //height: getProportionateScreenWidth(100),
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(5),),
                    bannerHeading("Bug report?",Icon(Icons.bug_report_outlined,color: kPrimaryColor,)),
                    SizedBox(height: getProportionateScreenWidth(10),),
                    bannerBody(
                        "You can mail any glitch, bug, suggestion or advice directly to us at admin@grojha.com."),
                    SizedBox(height: getProportionateScreenWidth(5),),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenWidth(5),),
                    bannerHeading("Questions and Queries?",Icon(Icons.question_answer_outlined,color: kPrimaryColor,)),
                    SizedBox(height: getProportionateScreenWidth(10),),
                    bannerBody(
                        "For business related questions and queries mail us at admin@grojha.com."),
                    // SizedBox(height: getProportionateScreenWidth(10),),
                    // bannerBody(
                    //     "For tech/development related questions and queries mail us to suman.saurav@grojha.com."),
                    SizedBox(height: getProportionateScreenWidth(5),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container bannerHeading(String text,Icon icon) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Row(children: [
          icon,SizedBox(width: getProportionateScreenWidth(10),),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(18),
              color: kPrimaryColor,
            ),
          )
        ],));
  }

  Container bannerBody(String text) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(15),
              //color: Colors.black,
              height: 1.1),
        ));
  }
}
