import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/components/cached_image.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/order_details/modified_order_details/components/recommended_products.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../../order_details_variables.dart';

class SingleOrderDetailsProductCard extends StatefulWidget {
  const SingleOrderDetailsProductCard(
      {Key key, this.shop, this.product, this.notifyOrderScreen, this.order, this.productNumber})
      : super(key: key);

  final Shop shop;
  final Product product;
  final Function() notifyOrderScreen;
  final Order order;
  final int productNumber;

  @override
  _SingleOrderDetailsProductCardState createState() =>
      _SingleOrderDetailsProductCardState();
}

class _SingleOrderDetailsProductCardState
    extends State<SingleOrderDetailsProductCard> {
  int productCartCount;

  int productTotalCartCost;
  String inStock = "In stock";
  String outOffStock = "Out of stock";
  String stock = "In stock";
  bool productStatus = true;
  Color inStockColor = Colors.green;
  Color outOffStockColor = Colors.red;
  Color stockColor = Colors.green;

  Color color = Colors.red;
  Color color1 = Colors.purple;

  @override
  Widget build(BuildContext context) {
    productCartCount = widget.product.productCartCount;
    productTotalCartCost = widget.product.productTotalCartCost;

    if (widget.product.productStatus != null && !widget.product.productStatus) {
      productStatus = false;
      stock = outOffStock;

      //OrderDetailsVariables.boolSet.add(widget.product.productId);

      stockColor = outOffStockColor;
    } else {
      OrderDetailsVariables.itemTotal += widget.product.productTotalCartCost;
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      width: double.infinity,
      //color: Colors.redAccent,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: (productStatus) ? Colors.white : Colors.yellow.shade100,
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(50),
                      width: getProportionateScreenWidth(50),
                      decoration: BoxDecoration(
                        //color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade300),
                        child: Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              child: CachedImage(
                                url: widget.product.productImage,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(10),
                    ),
                    Container(
                      height: getProportionateScreenWidth(95),
                      width: getProportionateScreenWidth(230),
                      //color: Colors.blueAccent,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: getProportionateScreenWidth(40),
                            width: double.infinity,
                            //   color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${widget.product.productName}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(13),
                                  height: 1.1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              height: getProportionateScreenWidth(18),
                              //    color: Colors.grey,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "per ${widget.product.productQuantity} ${widget.product.productUnit}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: getProportionateScreenWidth(12),
                                    height: 1),
                              )),
                          Container(
                            height: getProportionateScreenWidth(20),
                            alignment: Alignment.centerLeft,
                            // color: Colors.greenAccent,
                            child: Row(
                              children: [
                                //SizedBox(width: getProportionateScreenWidth(10),),
                                Text(
                                  "₹ ${widget.product.productSellingPrice}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: getProportionateScreenWidth(16),
                                    height: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Text(
                                  "x $productCartCount = ₹ ${productCartCount * widget.product.productSellingPrice}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: getProportionateScreenWidth(16),
                                    height: 1,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    left: getProportionateScreenWidth(-3),
                    top: getProportionateScreenWidth(-3),
                    child: Text(
                      "${widget.productNumber}",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  bottom: getProportionateScreenWidth(25),
                  right: getProportionateScreenWidth(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          stock,
                          style: TextStyle(
                              color: stockColor,
                              fontSize: getProportionateScreenWidth(12),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            if (!productStatus)
              Container(
                child: RecommendedProducts(
                  notifyScreen: widget.notifyOrderScreen,
                  productId: widget.product.productId,
                  orderId: widget.order.orderId,
                ),
              )
          ],
        ),
      ),
    );
  }
}
