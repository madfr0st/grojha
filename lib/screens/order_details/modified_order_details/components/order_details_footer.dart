import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/acceptModifiedOrder.dart';
import 'package:grojha/business_logic/cancel_order.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/event_status.dart';
import 'package:grojha/components/grad_button.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../order_details_variables.dart';

class OrderDetailsFooter extends StatefulWidget {
  const OrderDetailsFooter({
    Key key,
    this.order, this.notifyOrderScreen,
  }) : super(key: key);

  final Order order;
  final Function notifyOrderScreen;

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
                actionOrderButton(kPrimaryColor, kPrimaryColor, () {
                  _placeModifiedOrder(context);
                }, "Accept Modified")
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
        barrierDismissible: true,
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
                                  CancelOrder(order: widget.order).cancelOrder(notifySeller: true);
                                  EventStatus(popScreen: 3,context: context).success(notifyParent: widget.notifyOrderScreen);
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


  void _placeModifiedOrder(BuildContext context) {
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
                              "Grand Total ",
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
                        text: "Place Modified Order",
                        press: () {
                          if (correctInfo) {
                            AcceptedModifiedOrder(order: widget.order).acceptModifiedOrder();
                            EventStatus(popScreen: 3,context: context).success(notifyParent: widget.notifyOrderScreen);

                          }
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
}
