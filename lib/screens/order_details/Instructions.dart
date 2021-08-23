import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class Instructions {
  static Container orderStateBanner(String string) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Text(
        string,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Container orderNumberBanner(String orderNumber) {
    orderNumber = _orderNumber(orderNumber);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "Order Id: ",
            style: TextStyle(
              color: kSecondaryColor,
              fontWeight: FontWeight.w800,
              //fontStyle: FontStyle.italic,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
          TextSpan(
            text: "#${orderNumber}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              //fontStyle: FontStyle.italic,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
        ]),
      ),
    );
  }

  static String _orderNumber(String string){
    int size = string.length;
    for(int i=size;i<6;i++){
      string = "0"+string;
    }
    return string;
  }

}
