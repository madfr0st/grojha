import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/order_details/modified_order_details/components/single_product_card_order_select.dart';
import 'package:provider/provider.dart';

import '../../../../size_config.dart';
import '../../order_details_variables.dart';

class RecommendedProducts extends StatefulWidget {
  const RecommendedProducts({Key key, this.orderId, this.notifyScreen, this.parentProduct}) : super(key: key);

  final String orderId;
  final Product parentProduct;
  final Function notifyScreen;

  @override
  _RecommendedProductsState createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  List<Product> list = [];
  Product aboveProduct;
  bool priceChanged = false;
  bool limitedStock = false;

  void _refresh() {
    widget.notifyScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _logic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              for (int i = 0; i < list.length; i++) {
                if (widget.parentProduct.productId == list[i].productId) {
                  aboveProduct = list[i];
                  list.removeAt(i);
                  if (aboveProduct.productSellingPrice != widget.parentProduct.productSellingPrice) {
                    priceChanged = true;
                  }
                  if (aboveProduct.productCartCount != null && aboveProduct.productCartCount != 0 && aboveProduct.productCartCount != 99999999) {
                    limitedStock = true;
                  }
                }
              }

              return Column(
                children: [
                  if (aboveProduct != null)
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenWidth(10),
                          ),
                          modifiedProductHeading(),
                          SizedBox(
                            height: getProportionateScreenWidth(10),
                          ),
                          SingleProductCardOrderSelect(
                            product: aboveProduct,
                            function: _refresh,
                            orderId: widget.orderId,
                          ),
                        ],
                      ),
                    ),
                  if (list.length > 0)
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Instructions.banner_2("Recommended replacement that is in stock.", Colors.black, getProportionateScreenWidth(12), 2),
                          ),
                          ...List.generate(
                              list.length,
                              (index) => SingleProductCardOrderSelect(
                                    product: list[index],
                                    function: widget.notifyScreen,
                                    orderId: widget.orderId,
                                  ))
                        ],
                      ),
                    )
                ],
              );
            } else {
              return Center();
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        });
  }

  Future<bool> _logic() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("modifiedOrderDetails/${widget.orderId}/${widget.parentProduct.productId}");
    return await databaseReference.once().then((snapshot) {
      if (snapshot.value != null) {
        try {
          list.clear();
          OrderDetailsVariables.modifiedProductIdList.clear();
          Map<dynamic, dynamic> map = snapshot.value;
          map.forEach((key, value) {
            OrderDetailsVariables.modifiedProductIdList.add(Product(
                productId: key,
                productName: value["productName"],
                productImage: value["productImage"],
                productCategory: value["productCategory"],
                productUnit: value["productUnit"],
                productSellingPrice: value["productSellingPrice"],
                productMRP: value["productMRP"],
                productStatus: value["productStatus"],
                productQuantity: value["productQuantity"],
                productCartCount: value["productCartCount"],
                productDiscountPercentage: calcPercentage(value["productSellingPrice"], value["productMRP"])));

            list.add(new Product(
                productId: key,
                productName: value["productName"],
                productImage: value["productImage"],
                productCategory: value["productCategory"],
                productUnit: value["productUnit"],
                productSellingPrice: value["productSellingPrice"],
                productMRP: value["productMRP"],
                productStatus: value["productStatus"],
                productQuantity: value["productQuantity"],
                productCartCount: value["productCartCount"],
                productDiscountPercentage: calcPercentage(value["productSellingPrice"], value["productMRP"])));
          });

          for (int i = 0; i < list.length; i++) {
            if (list[i].productCartCount == null || list[i].productCartCount == 0) {
              list[i].productCartCount = 99999999;
            }
            if (OrderDetailsVariables.modifiedAddedProductCartCount[widget.orderId + " " + list[i].productId] == null) {
              OrderDetailsVariables.modifiedAddedProductCartCount[widget.orderId + " " + list[i].productId] = 0;
              // if(list[i].productCartCount!=99999999){
              //   OrderDetailsVariables.modifiedAddedProductCartCount[widget.orderId + " " + list[i].productId] = list[i].productCartCount;
              // }
            }
          }

          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
      return false;
    });
  }

  int calcPercentage(int a, int b) {
    try {
      int c = a * 100;
      var d = (c / b);
      c = d.ceil().toInt();
      c = 100 - c;
      return c;
    } catch (e) {
      return 0;
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

  Container modifiedProductHeading() {
    if (priceChanged && !limitedStock) {
      return Container(
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(12),
            ),
            children: [
              TextSpan(text: 'Sorry, selling price of above product changed from '),
              TextSpan(
                text: '₹ ${widget.parentProduct.productSellingPrice} ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'to ',
              ),
              TextSpan(
                text: '₹ ${aboveProduct.productSellingPrice}.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    if (!priceChanged && limitedStock) {
      return Container(
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(12),
            ),
            children: [
              TextSpan(text: 'Sorry, for now only '),
              TextSpan(
                text: '${aboveProduct.productCartCount} ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'quantity of '),
              TextSpan(
                text: '${aboveProduct.productName} ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: 'left with seller.'),
            ],
          ),
        ),
      );
    }

    return Container(
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(12),
          ),
          children: [
            TextSpan(text: 'Sorry, selling price of above product changed from '),
            TextSpan(
              text: '₹ ${widget.parentProduct.productSellingPrice} ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'to ',
            ),
            TextSpan(
              text: '₹ ${aboveProduct.productSellingPrice} ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: 'for now only '),
            TextSpan(
              text: '${aboveProduct.productCartCount} ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: 'quantity of '),
            TextSpan(
              text: '${aboveProduct.productName} ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: 'left with seller.'),
          ],
        ),
      ),
    );
  }
}
