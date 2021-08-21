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
    this.notifyOrderScreen, this.order,
  }) : super(key: key);
  final Function() notifyOrderScreen;
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
                          "₹ ${OrderDetailsVariables.delivery}",
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
                          "₹ ${OrderDetailsVariables.itemTotal + OrderDetailsVariables.delivery}",
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
            child:  buildOTPContainer(context),
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
          actionOrderButton(kPrimaryColor, kPrimaryColor, () {_refreshCode();}, "Refresh" )
        ],
      ),
    );
  }

  void _refreshCode(){
    setState(() {
      code = randomCode();
    });
    RefreshCode(order: widget.order,code:code).refreshCode();
  }

  int randomCode(){
    Random random = new Random();
    int randomNumber = random.nextInt(900000)+100000;
    return randomNumber;
  }

  void _rejectOrder() {
    String uid = FirebaseAuth.instance.currentUser.uid;

    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(widget.order.userId)
        .child("orders")
        .child(widget.order.orderId)
        .child("orderState");

    DatabaseReference databaseReference1 = FirebaseDatabase.instance
        .reference()
        .child("orders")
        .child(widget.order.orderId)
        .child("orderState");

    DatabaseReference databaseReference2 = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(uid)
        .child("orders")
        .child(widget.order.orderId)
        .child("orderState");




    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: double.infinity,
              height: getProportionateScreenWidth(200),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CheckboxListTile(
                        activeColor: kPrimaryColor,
                        title: Text(
                          "Are you sure",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(15),
                            color: kPrimaryColor,
                          ),
                        ),
                        value: areYouSure,
                        onChanged: (newValue) {
                          setState(() {
                            areYouSure = newValue;
                            print(areYouSure);
                          });
                        },
                      ),
                      Container(
                        height: getProportionateScreenHeight(56),
                        width: double.infinity,
                        child: DefaultButton(
                          text: "Reject Order",
                          press: () {
                            if (areYouSure) {
                              databaseReference.set("rejected");
                              databaseReference1.set("rejected");
                              databaseReference2.set("rejected");
                              _success();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  void _modifyOrder(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("info");
    Color color = Colors.blue;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: getProportionateScreenWidth(250),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: double.infinity,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: getProportionateScreenWidth(30),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.lightGreenAccent.withOpacity(0.7),
                                Colors.lightGreenAccent.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        //      color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total : ",
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.indigo,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹ ${OrderDetailsVariables.itemTotal + OrderDetailsVariables.delivery}",
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.indigo,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    CheckboxListTile(
                      activeColor: kPrimaryColor,
                      title: Text(
                        "Confirm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                          color: kPrimaryColor,
                        ),
                      ),
                      value: correctInfo,
                      onChanged: (newValue) {
                        setState(() {
                          correctInfo = newValue;
                          print(correctInfo);
                        });
                      },
                    ),
                    Container(
                      height: getProportionateScreenHeight(56),
                      width: double.infinity,
                      child: DefaultButton(
                        text: "Accept Order",
                        press: () {
                          if (correctInfo) {}
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void _acceptOrder(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("info");
    Color color = Colors.blue;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: getProportionateScreenWidth(250),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: double.infinity,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: getProportionateScreenWidth(30),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.lightGreenAccent.withOpacity(0.7),
                                Colors.lightGreenAccent.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        //      color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total : ",
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.indigo,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹ ${OrderDetailsVariables.itemTotal + OrderDetailsVariables.delivery}",
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.indigo,
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    CheckboxListTile(
                      activeColor: kPrimaryColor,
                      title: Text(
                        "Confirm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(15),
                          color: kPrimaryColor,
                        ),
                      ),
                      value: correctInfo,
                      onChanged: (newValue) {
                        setState(() {
                          correctInfo = newValue;
                          print(correctInfo);
                        });
                      },
                    ),
                    Container(
                      height: getProportionateScreenHeight(56),
                      width: double.infinity,
                      child: DefaultButton(
                        text: "Accept Order",
                        press: () {
                          if (correctInfo) {}
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void _error() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            width: double.infinity,
            height: getProportionateScreenWidth(100),
            child: Center(
              child: GradButton(
                name: "Some fields are empty",
                color1: Colors.redAccent,
                color2: Colors.redAccent,
                press: () {},
              ),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
      //pop dialog
    });
  }

  void _success() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            width: double.infinity,
            height: getProportionateScreenWidth(100),
            child: Center(
              child: GradButton(
                name: "Success",
                color1: Colors.greenAccent,
                color2: Colors.greenAccent,
                press: () {},
              ),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      //pop dialog
    });
  }
}
