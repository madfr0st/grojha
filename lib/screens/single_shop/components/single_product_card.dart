import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/product_count.dart';
import 'package:grojha/size_config.dart';

class SingleProductCard extends StatefulWidget {
  const SingleProductCard({
    Key key,
    this.product,
    this.shop,
  }) : super(key: key);

  final Product product;
  final Shop shop;

  @override
  _SingleProductCardState createState() => _SingleProductCardState();
}

class _SingleProductCardState extends State<SingleProductCard> {
  int productCartCount = 0;
  int productTotalCost = 0;
  int productDicountPercent = 0;



  void _addProductToCart() {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart");
    if (productCartCount == 0) {
      databaseReference
          .child(widget.shop.shopId)
          .child(widget.product.productId)
          .set({});
    } else {
      databaseReference
          .child(widget.shop.shopId)
          .child(widget.product.productId)
          .set({
        "productCartCount": productCartCount,
        "productTotalCartCost":
            (productCartCount * widget.product.productSellingPrice),
        "shopCategory": widget.shop.shopCategory,
        "shopImage": widget.shop.shopImage,
        "shopName": widget.shop.shopName,
        "productName": widget.product.productName,
        "productImage": widget.product.productImage,
        "productQuantity": widget.product.productQuantity,
        "productSellingPrice": widget.product.productSellingPrice,
        "productUnit": widget.product.productUnit,
      });
    }
  }

  int toInt(String a) {
    try {
      var myInt = int.parse(a);
      assert(myInt is int);
      return myInt;
    } catch (e) {
      return 0;
    }
  }

  void _showCartMessage() {}

  @override
  Widget build(BuildContext context) {
    productDicountPercent = calcPercentage(
        widget.product.productSellingPrice, widget.product.productMRP);
    if(ProductCount.map.containsKey(widget.shop.shopId+widget.product.productId)){
      productCartCount = ProductCount.map[widget.shop.shopId+widget.product.productId];
    }
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: getProportionateScreenWidth(140),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenWidth(100),
                width: getProportionateScreenWidth(100),
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
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            child: Image.network(widget.product.productImage,
                                fit: BoxFit.fill),
                          )),
                    ),
                    buildPositionedDisproductCartCountBanner()
                  ],
                ),
              ),
              Container(
                height: getProportionateScreenWidth(100),
                width: getProportionateScreenWidth(230),
                //color: Colors.blueAccent,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(45),
                      width: double.infinity,
                      // color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.product.productName}",
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
                          Text(
                            "₹ ${widget.product.productMRP}",
                            style: TextStyle(
                              //color: Colors.black12,
                              decoration: TextDecoration.lineThrough,
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
            bottom: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
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
                              ProductCount.map[widget.shop.shopId+widget.product.productId] = productCartCount;
                              _addProductToCart();
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
                            _addProductToCart();
                            ProductCount.map[widget.shop.shopId+widget.product.productId] = productCartCount;
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
    );
  }

  Positioned buildPositionedDisproductCartCountBanner() {
    if (productDicountPercent > 0) {
      return Positioned(
        bottom: -12.5,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: getProportionateScreenWidth(25),
          width: getProportionateScreenWidth(80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.lightGreen,
          ),
          child: Text(
            "$productDicountPercent% off",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12), color: Colors.black),
          ),
        ),
      );
    } else {
      return Positioned(
          bottom: -12.5,
          child: Container(
            height: 1,
            width: 1,
          ));
    }
  }

  int calcPercentage(int a, int b) {
    try {
      int c = a * 100;
      var d = (c / b);
      c = d.toInt();
      c = 100 - c;
      return c;
    } catch (e) {
      return 0;
    }
  }
}
