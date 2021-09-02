import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/refresh_code.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/grad_button.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../order_details_variables.dart';

class OrderDetailsFooter extends StatefulWidget {
  const OrderDetailsFooter({
    Key key,
    this.notifyOrderScreen,
    this.order,
  }) : super(key: key);
  final Function notifyOrderScreen;
  final Order order;

  @override
  _OrderDetailsFooterState createState() => _OrderDetailsFooterState();
}

class _OrderDetailsFooterState extends State<OrderDetailsFooter> {
  bool correctInfo = false;
  String userName;
  String userPhoneNumber;
  String userAddress;
  bool areYouSure = false;
  String orderButtonStatus = "Accept Order";
  String acceptOrder = "Accept Order";
  String modifyOrder = "Modify Order";
  int code;

  @override
  Widget build(BuildContext context) {
    if (OrderDetailsVariables.boolSet.isNotEmpty) {
      orderButtonStatus = modifyOrder;
    } else {
      orderButtonStatus = acceptOrder;
    }
    return Container(
      height: getProportionateScreenWidth(150),
      margin: EdgeInsets.fromLTRB(5, 20, 5, 40),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: getProportionateScreenWidth(65),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: getProportionateScreenWidth(20),
                  width: double.infinity,
                  // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item Total",
                        style: TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(12)),
                      ),
                      Text(
                        "₹ ${OrderDetailsVariables.itemTotal}",
                        style: TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(12)),
                      )
                    ],
                  ),
                ),
                Container(
                    height: getProportionateScreenWidth(20),
                    width: double.infinity,
                    //      color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: TextStyle(
                              height: 1,
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(12)),
                        ),
                        Text(
                          "₹ ${widget.order.deliveryCharge}",
                          style: TextStyle(
                              height: 1,
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(12)),
                        )
                      ],
                    )),
                Container(
                    height: getProportionateScreenWidth(25),
                    width: double.infinity,
                    //      color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grand Total",
                          style: TextStyle(
                              height: 1,
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹ ${OrderDetailsVariables.itemTotal + widget.order.deliveryCharge}",
                          style: TextStyle(
                              height: 1,
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Container(
            height: getProportionateScreenWidth(60),
            width: double.infinity,
            //    color: Colors.lightGreenAccent,
            child: buildOTPContainer(context),
          ),
        ],
      ),
    );
  }

  Container actionOrderButton(
      Color borderColor, Color fillColor, GestureTapCallback press, name) {
    return Container(
      height: getProportionateScreenWidth(50),
      width: SizeConfig.screenWidth * .45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: getProportionateScreenWidth(50),
        width: SizeConfig.screenWidth * .45,
        padding: EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              borderColor.withOpacity(1),
              borderColor.withOpacity(0),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: press,
            child: Container(
              //margin: EdgeInsets.all(),
              height: getProportionateScreenWidth(50),
              alignment: Alignment.center,
              width: SizeConfig.screenWidth * .45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    fillColor.withOpacity(.9),
                    fillColor.withOpacity(.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "$name",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(17),
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildOTPContainer(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(60),
      width: double.infinity,
      //    color: Colors.lightGreenAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          actionOrderButton(kPrimaryColor, Colors.white, () {}, "$code"),
          actionOrderButton(kPrimaryColor, kPrimaryColor, () {
            _refreshCode(context);
          }, "Refresh")
        ],
      ),
    );
  }

  void _refreshCode(BuildContext context) {
    setState(() {
      code = randomCode();
    });
    RefreshCode(
      order: widget.order,
      code: code,
      context: context,
    ).refreshCode(notifyParent: widget.notifyOrderScreen);
  }

  int randomCode() {
    Random random = new Random();
    int randomNumber = random.nextInt(900000) + 100000;
    return randomNumber;
  }
}
