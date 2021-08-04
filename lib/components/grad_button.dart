import 'package:flutter/material.dart';

import '../size_config.dart';

class GradButton extends StatelessWidget {
  final GestureTapCallback press;
  final Color color1;
  final Color color2;
  final String name;

  const GradButton({
    Key key,
    this.press,
    this.color1,
    this.color2,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(10),
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: press,
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              //height: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color1.withOpacity(0.7),
                      color2.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "$name",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: Colors.black),
              ),
            )));
  }
}