import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/cancel_order.dart';
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


  @override
  Widget build(BuildContext context) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                actionOrderButton(
                  kPrimaryColor,
                  Colors.white,
                  () {
                    _cancelOrder();
                  },
                  "Cancel Order",
                ),
                 ],
            ),
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

  void _cancelOrder() {
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
                          text: "Cancel Order",
                          press: () {
                            if (areYouSure) {
                              print("sdadada");
                              CancelOrder(order: widget.order).cancelOrder();
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
