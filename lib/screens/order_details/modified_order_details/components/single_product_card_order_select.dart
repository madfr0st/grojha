import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/components/cached_image.dart';
import 'package:grojha/components/custom_button.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../order_details_variables.dart';

class SingleProductCardOrderSelect extends StatefulWidget {
  const SingleProductCardOrderSelect(
      {Key key, this.product, this.function, this.orderId})
      : super(key: key);
  final Product product;
  final Function function;
  final String orderId;

  @override
  _SingleProductCardOrderSelectState createState() =>
      _SingleProductCardOrderSelectState();
}

class _SingleProductCardOrderSelectState
    extends State<SingleProductCardOrderSelect> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (OrderDetailsVariables.modifiedAddedProductCartCount[
            widget.orderId + " " + widget.product.productId] ==
        null) {
      OrderDetailsVariables.modifiedAddedProductCartCount[
          widget.orderId + " " + widget.product.productId] = 0;
    }

    if (widget.product.productCartCount == null ||
        widget.product.productCartCount == 0) {
      widget.product.productCartCount = 99999999;
    }

    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(0),
            vertical: getProportionateScreenWidth(3)),
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        height: getProportionateScreenWidth(110),
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: Offset(3, 3), // changes position of shadow
          //   ),
          // ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: getProportionateScreenWidth(70),
                  width: getProportionateScreenWidth(70),
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300),
                        child: Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Colors.white),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                                child: CachedImage(
                                    url: widget.product.productImage))),
                      ),
                      buildPositionedDiscountBanner()
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(100),
                      width: getProportionateScreenWidth(230),
                      //  color: Colors.blueAccent,
                      padding: EdgeInsets.fromLTRB(
                          getProportionateScreenWidth(10), 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: getProportionateScreenWidth(45),
                            width: double.infinity,
                            // color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.product.productName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15),
                                  height: 1.1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              height: getProportionateScreenWidth(20),
                              //color: Colors.grey,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "per ${widget.product.productQuantity} ${widget.product.productUnit}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              )),
                          Container(
                            height: getProportionateScreenWidth(30),
                            //color: Colors.greenAccent,
                            child: Row(
                              children: [
                                //SizedBox(width: getProportionateScreenWidth(10),),
                                Text(
                                  "₹ ${widget.product.productSellingPrice}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(18),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                (widget.product.productSellingPrice !=
                                        widget.product.productMRP)
                                    ? Text("₹ ${widget.product.productMRP}",
                                        style: TextStyle(
                                          //color: Colors.black12,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ))
                                    : Container(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(0),
                        child: Column(
                          children: [
                            Transform.scale(
                              scale: .9,
                              child: Container(
                                height: getProportionateScreenWidth(27),
                                width: getProportionateScreenWidth(81),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Row(
                                    children: [
                                      Material(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(7),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          onTap: () {
                                            if (OrderDetailsVariables
                                                        .modifiedAddedProductCartCount[
                                                    widget.orderId +
                                                        " " +
                                                        widget.product
                                                            .productId] >
                                                0) {
                                              HapticFeedback.lightImpact();
                                              OrderDetailsVariables
                                                      .modifiedAddedProductCartCount[
                                                  widget.orderId +
                                                      " " +
                                                      widget
                                                          .product.productId]--;
                                              OrderDetailsVariables.itemTotal -=
                                                  widget.product
                                                      .productSellingPrice;
                                              setState(() {
                                                widget.function();
                                              });
                                            }
                                          },
                                          child: Container(
                                            width:
                                                getProportionateScreenWidth(27),
                                            height:
                                                getProportionateScreenWidth(27),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(),
                                            child: Icon(
                                              Icons.remove_outlined,
                                              size: getProportionateScreenWidth(
                                                  18),
                                              color: (OrderDetailsVariables
                                                              .modifiedAddedProductCartCount[
                                                          widget.orderId +
                                                              " " +
                                                              widget.product
                                                                  .productId] >
                                                      0)
                                                  ? Colors.white
                                                  : Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: getProportionateScreenWidth(27),
                                        height: getProportionateScreenWidth(27),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          OrderDetailsVariables
                                              .modifiedAddedProductCartCount[
                                                  widget.orderId +
                                                      " " +
                                                      widget.product.productId]
                                              .toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      12),
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(7),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          onTap: () {
                                            if (OrderDetailsVariables
                                                        .modifiedAddedProductCartCount[
                                                    widget.orderId +
                                                        " " +
                                                        widget.product
                                                            .productId] <
                                                widget
                                                    .product.productCartCount) {
                                              OrderDetailsVariables
                                                      .modifiedAddedProductCartCount[
                                                  widget.orderId +
                                                      " " +
                                                      widget
                                                          .product.productId]++;
                                              OrderDetailsVariables
                                                  .modifiedProductSet
                                                  .add(widget.product);
                                              HapticFeedback.lightImpact();
                                              OrderDetailsVariables.itemTotal +=
                                                  widget.product
                                                      .productSellingPrice;
                                              setState(() {
                                                widget.function();
                                              });
                                            }
                                          },
                                          child: Container(
                                            width:
                                                getProportionateScreenWidth(27),
                                            height:
                                                getProportionateScreenWidth(27),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(),
                                            child: Icon(
                                              Icons.add_outlined,
                                              size: getProportionateScreenWidth(
                                                  18),
                                              color: (OrderDetailsVariables
                                                              .modifiedAddedProductCartCount[
                                                          widget.orderId +
                                                              " " +
                                                              widget.product
                                                                  .productId] <
                                                      widget.product
                                                          .productCartCount)
                                                  ? Colors.white
                                                  : Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (widget.product.productCartCount != 99999999)
                              Text(
                                "Only ${widget.product.productCartCount} left",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(12),
                                    fontWeight: FontWeight.bold),
                              ),
                          ],
                        )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildPositionedDiscountBanner() {
    if (widget.product.productDiscountPercentage > 0) {
      return Positioned(
          bottom: -12.5,
          child: Container(
            alignment: Alignment.center,
            height: getProportionateScreenWidth(20),
            width: getProportionateScreenWidth(70),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: kPrimaryColor),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(3)),
              margin: EdgeInsets.all(getProportionateScreenWidth(2)),
              height: getProportionateScreenWidth(25),
              width: getProportionateScreenWidth(80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Text(
                "${widget.product.productDiscountPercentage}% off",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(11),
                    color: Colors.black,
                    height: 1),
              ),
            ),
          ));
    } else {
      return Positioned(
          bottom: -12.5,
          child: Container(
            height: 1,
            width: 1,
          ));
    }
  }
}
