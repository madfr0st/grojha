import 'package:flutter/material.dart';

import '../../../constants.dart';
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
                    bannerHeading("App not working?",Icon(Icons.report_problem_outlined,color: kPrimaryColor,)),
                    SizedBox(height: getProportionateScreenWidth(10),),
                    bannerBody(
                        "In case of emergency tech support like app not working or major bug. Email us on admin@grojha.com or ping us on +91 77135 10615."),
                    // SizedBox(height: getProportionateScreenWidth(10),),
                    // bannerBody(
                    //     "For tech/development related questions and queries mail us to suman.saurav@grojha.com."),
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
                    bannerHeading("On-field Support?",Icon(Icons.support_agent_outlined,color: kPrimaryColor,)),
                    SizedBox(height: getProportionateScreenWidth(10),),
                    bannerBody(
                        "In case of emergency field support like business related issues. Email us on admin@grojha.com or ping us on +91 74398 52955."),
                    // SizedBox(height: getProportionateScreenWidth(10),),
                    // bannerBody(
                    //     "For tech/development related questions and queries mail us to suman.saurav@grojha.com."),
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
                    bannerHeading("Office Address",Icon(Icons.other_houses_outlined,color: kPrimaryColor,)),
                    SizedBox(height: getProportionateScreenWidth(10),),
                    bannerBody(
                        "Grojha, 91-Bus Route, Near BLR Office, opposite Bhagwati Kunj Apartment, Rajarhat station, Kolkata -700135."),
                    // SizedBox(height: getProportionateScreenWidth(10),),
                    // bannerBody(
                    //     "For tech/development related questions and queries mail us to suman.saurav@grojha.com."),
                    SizedBox(height: getProportionateScreenWidth(5),),
                  ],
                ),
              ),

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
          text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(16),
              height: 1.2
          ),
        ),
      ),
    );
    // return Container(
    //     alignment: Alignment.centerLeft,
    //     child: Text(
    //       text,
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: getProportionateScreenWidth(15),
    //           //color: Colors.black,
    //           height: 1.1),
    //     ));
  }
}
