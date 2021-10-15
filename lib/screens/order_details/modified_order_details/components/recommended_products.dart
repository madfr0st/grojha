import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/order_details/modified_order_details/components/single_product_card_order_select.dart';

class RecommendedProducts extends StatefulWidget {
  const RecommendedProducts(
      {Key key, this.orderId, this.productId, this.notifyScreen})
      : super(key: key);

  final String orderId;
  final String productId;
  final Function notifyScreen;

  @override
  _RecommendedProductsState createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  List<Product> list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _logic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Column(
                children: [
                  Container(
                    child: Instructions.banner_2(
                        "Recommended replacement that is in stock",
                        kPrimaryColor,
                        13,
                        2),
                  ),
                  ...List.generate(
                      list.length,
                      (index) => SingleProductCardOrderSelect(
                            product: list[index],
                            function: widget.notifyScreen,
                            orderId: widget.orderId,
                          ))
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
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("modifiedOrderDetails/${widget.orderId}/${widget.productId}");
    return await databaseReference.once().then((snapshot) {
      if (snapshot.value != null) {
        try {
          list.clear();
          Map<dynamic, dynamic> map = snapshot.value;
          map.forEach((key, value) {
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
                productDiscountPercentage: calcPercentage(
                    value["productSellingPrice"], value["productMRP"])));
          });
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
}
