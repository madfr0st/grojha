import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/business_logic/place_order.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/event_status.dart';
import 'package:grojha/components/grad_button.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/complete_profile/complete_profile_screen.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import 'package:grojha/size_config.dart';

class PlaceOrderFooter extends StatefulWidget {
  const PlaceOrderFooter({
    Key key,
    this.notifyHome, this.product, this.uniqueItems,
  }) : super(key: key);
  final Function() notifyHome;
  final Product product;
  final int uniqueItems;

  @override
  _PlaceOrderFooterState createState() => _PlaceOrderFooterState();
}

class _PlaceOrderFooterState extends State<PlaceOrderFooter> {
  bool correctInfo = false;
  String userName;
  String userPhoneNumber;
  String userAddress;
  bool areYouSure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(140),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(-3, -3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        "₹ ${PlaceOrderVariables.itemTotal}",
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
                          "₹ ${PlaceOrderVariables.delivery}",
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
                          "₹ ${PlaceOrderVariables.itemTotal + PlaceOrderVariables.delivery}",
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
                actionOrderButton(kPrimaryColor,
                  Colors.white,
                  () {
                    _clearCart();
                  },
                  "Clear Cart",
                ),
                actionOrderButton(kPrimaryColor,kPrimaryColor, () {
                  placeOrder(context);
                }, "Place Order")
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _clearCart() {
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
                          text: "Clear Cart",
                          press: () {
                            if (areYouSure) {
                              _emptyCart();
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

  void _emptyCart() {
    Order order = new Order(
      orderState: "pending",
      shopId: PlaceOrderVariables.shop.shopId,
      shopName: PlaceOrderVariables.shop.shopName,
      deliveryCharge: PlaceOrderVariables.delivery,
      grandTotal: PlaceOrderVariables.itemTotal + PlaceOrderVariables.delivery,
      productList: PlaceOrderVariables.list,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      userAddress: userAddress,
      shopImage: PlaceOrderVariables.shop.shopImage,
      orderImage: widget.product.productImage,
      uniqueItems: widget.uniqueItems,
    );

    PlaceOrder(order: order).clearCart(shopUid: order.shopId);
    EventStatus(context: context,popScreen: 3).success(notifyParent: widget.notifyHome);



  }

  void _pushOrder() {
    Order order = new Order(
      orderState: "pending",
      shopId: PlaceOrderVariables.shop.shopId,
      shopName: PlaceOrderVariables.shop.shopName,
      deliveryCharge: PlaceOrderVariables.delivery,
      grandTotal: PlaceOrderVariables.itemTotal + PlaceOrderVariables.delivery,
      productList: PlaceOrderVariables.list,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      userAddress: userAddress,
      shopImage: PlaceOrderVariables.shop.shopImage,
      orderImage: widget.product.productImage,
      uniqueItems: widget.uniqueItems,
    );

    PlaceOrder(order: order).pushOrder();
    EventStatus(context: context,popScreen: 3).success(notifyParent: widget.notifyHome);


  }


  void placeOrder(BuildContext context) {
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
              height: getProportionateScreenWidth(330),
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: double.infinity,
              child: FutureBuilder(
                  future: databaseReference.once(),
                  builder: (context, snapShot) {
                    try {
                      if (snapShot.hasData) {
                        //print(snapShot.data.value);
                        Map<dynamic, dynamic> values = snapShot.data.value;
                        userName = values["userName"];
                        userPhoneNumber = values["userPhoneNumber"];
                        userAddress = values["userAddress"];
                        //print("working------------");
                        // print(userAddress);
                        // print(userPhoneNumber);

                      }
                      return Container(
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
                                      color.withOpacity(0.7),
                                      color.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Name : $userName",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(15),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: getProportionateScreenWidth(30),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      color.withOpacity(0.7),
                                      color.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Contact Number : $userPhoneNumber",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(15),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              height: getProportionateScreenWidth(60),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      color.withOpacity(0.7),
                                      color.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Adderss : $userAddress",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: getProportionateScreenWidth(15),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                height: getProportionateScreenWidth(30),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.lightGreenAccent
                                            .withOpacity(0.7),
                                        Colors.lightGreenAccent
                                            .withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                //      color: Colors.grey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Grand Total : ",
                                      style: TextStyle(
                                          height: 1,
                                          color: Colors.indigo,
                                          fontSize:
                                              getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹ ${PlaceOrderVariables.itemTotal + PlaceOrderVariables.delivery}",
                                      style: TextStyle(
                                          height: 1,
                                          color: Colors.indigo,
                                          fontSize:
                                              getProportionateScreenWidth(20),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                            CheckboxListTile(
                              activeColor: kPrimaryColor,
                              title: Text(
                                "Confirm Details ",
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
                                text: "Place Order",
                                press: () {
                                  if (correctInfo) {
                                    _pushOrder();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    } catch (e) {
                      print(e);
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Your profile is empty.",style: TextStyle(
                              color: Colors.red,
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: getProportionateScreenWidth(30),),
                            DefaultButton(
                              text: "Complete Profile",
                              press: (){
                                Navigator.pop(context);
                                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                              },
                            ),
                          ],
                        )
                      );
                    }
                    // return Center(
                    //   child: CircularProgressIndicator(),
                    // );
                  }),
            );
          });
        });
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
  Container placeOrderButton(Color color, GestureTapCallback press, name) {
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
              color.withOpacity(1),
              color.withOpacity(0),
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
                    color.withOpacity(.7),
                    color.withOpacity(.1),
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
}
