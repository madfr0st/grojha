import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/grad_button.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import 'package:grojha/size_config.dart';

class PlaceOrderFooter extends StatefulWidget {
  const PlaceOrderFooter({
    Key key,
    this.notifyParent,
  }) : super(key: key);
  final Function() notifyParent;

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
                placeOrderButton(
                  Colors.grey,
                  () {
                    _clearCart();
                  },
                  "Clear Cart",
                ),
                placeOrderButton(Colors.orange, () {
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
    String uid = FirebaseAuth.instance.currentUser.uid;

    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart")
        .child(PlaceOrderVariables.shop.shopId);

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
                          text: "Clear Cart",
                          press: () {
                            if (areYouSure) {
                              databaseReference.set({});
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

  void _pushOrder() {
    String uid = FirebaseAuth.instance.currentUser.uid;

    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("orders");

    String orderKey = databaseReference.push().key;

    print(orderKey);

    Order order = new Order(
      orderId: orderKey,
      orderState: "pending",
      //orderTime: ServerValue.timestamp,
      shopId: PlaceOrderVariables.shop.shopId,
      shopName: PlaceOrderVariables.shop.shopName,
      deliveryCharge: PlaceOrderVariables.delivery,
      grandTotal: PlaceOrderVariables.itemTotal + PlaceOrderVariables.delivery,
      userId: uid,
      productList: PlaceOrderVariables.list,
      userName: userName,
      userPhoneNumber: userPhoneNumber,
      userAddress: userAddress,
      shopImage: PlaceOrderVariables.shop.shopImage,
    );

    databaseReference.child(orderKey).set({
      "orderId": order.orderId,
      "orderState": order.orderState,
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
    });

    DatabaseReference databaseReference1 = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(PlaceOrderVariables.shop.shopId)
        .child("orders");

    databaseReference1.child(orderKey).set({
      "orderId": order.orderId,
      "orderState": order.orderState,
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
    });

    DatabaseReference databaseReference2 = FirebaseDatabase.instance
        .reference()
        .child("orders");

    databaseReference2.child(orderKey).set({
      "orderId": order.orderId,
      "orderState": order.orderState,
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
    });

    for (int i = 0; i < order.productList.length; i++) {
      databaseReference2.child(orderKey).child("productList").push().set({
        "productId": order.productList[i].productId,
        "productImage": order.productList[i].productImage,
        "productUnit": order.productList[i].productUnit,
        "productQuantity": order.productList[i].productQuantity,
        "productName": order.productList[i].productName,
        "productTotalCartCost": order.productList[i].productTotalCartCost,
        "productCartCount": order.productList[i].productCartCount,
        "productMRP": order.productList[i].productMRP,
        "productSellingPrice": order.productList[i].productSellingPrice,
        "productStatus":true,
      });
    }

    DatabaseReference databaseReference4 = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart")
        .child(PlaceOrderVariables.shop.shopId);


    databaseReference4.set({});
    _success();

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
                        child: Text("Some error Occured\n Update your profile"),
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
