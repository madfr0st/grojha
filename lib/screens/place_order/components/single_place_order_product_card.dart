import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/add_product_to_cart.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';

import '../../../size_config.dart';

class SinglePlaceOrderProductCard extends StatefulWidget {
  const SinglePlaceOrderProductCard(
      {Key key, this.shop, this.product, this.notifyHomeScreen})
      : super(key: key);

  final Shop shop;
  final Product product;
  final Function notifyHomeScreen;

  @override
  _SinglePlaceOrderProductCardState createState() =>
      _SinglePlaceOrderProductCardState();
}

class _SinglePlaceOrderProductCardState
    extends State<SinglePlaceOrderProductCard> {
  int productCartCount;
  int productTotalCartCost;

  _SinglePlaceOrderProductCardState();

  Color color = Colors.red;
  Color color1 = Colors.purple;

  @override
  Widget build(BuildContext context) {
    productCartCount = CartItemCount
        .map[widget.shop.shopId + widget.product.productId];
    productTotalCartCost =
        productCartCount * widget.product.productSellingPrice;
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      height: getProportionateScreenWidth(96),
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
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: getProportionateScreenWidth(100),
        width: double.infinity,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Stack(
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
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Image.network(widget.product.productImage,
                              fit: BoxFit.fill),
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
              bottom: getProportionateScreenWidth(25),
              right: getProportionateScreenWidth(5),
              child: Container(
                height: getProportionateScreenWidth(25),
                width: getProportionateScreenWidth(75),
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
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            if (productCartCount > 0) {
                              productCartCount--;
                              setState(() {
                                PlaceOrderVariables.itemTotal -=
                                    widget.product.productSellingPrice;
                                CartItemCount.map[
                                        widget.shop.shopId +
                                            widget.product.productId] =
                                    productCartCount;
                                AddProductToCart.addProductToCart(
                                    productCartCount: productCartCount,
                                    shop: widget.shop,
                                    product: widget.product);
                                if (productCartCount == 0) {
                                  CartItemCount.decreaseItemCount(itemCount: 1);
                                  CartItemCount.cartItemCount--;
                                }
                                widget.notifyHomeScreen();
                              });
                            }
                          },
                          child: Container(
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenWidth(25),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(),
                            child: Icon(
                              Icons.remove_outlined,
                              size: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: getProportionateScreenWidth(25),
                        height: getProportionateScreenWidth(25),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          "$productCartCount",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Material(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(7),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () {
                            productCartCount++;
                            setState(() {
                              PlaceOrderVariables.itemTotal +=
                                  widget.product.productSellingPrice;
                              CartItemCount.map[widget
                                      .shop.shopId +
                                  widget.product.productId] = productCartCount;
                              AddProductToCart.addProductToCart(
                                  productCartCount: productCartCount,
                                  shop: widget.shop,
                                  product: widget.product);
                              if (productCartCount == 0) {
                                CartItemCount.increaseItemCount(itemCount: 1);
                                CartItemCount.cartItemCount++;
                              }
                              widget.notifyHomeScreen();
                            });
                          },
                          child: Container(
                            width: getProportionateScreenWidth(25),
                            height: getProportionateScreenWidth(25),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(),
                            child: Icon(
                              Icons.add_outlined,
                              size: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
