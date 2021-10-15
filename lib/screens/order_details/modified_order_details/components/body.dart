import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/Objects/product.dart';
import '../../../../constants.dart';
import 'details.dart';
import '../../order_details_variables.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.order, this.notifyOrderScreen}) : super(key: key);
  final Function notifyOrderScreen;
  final Order order;

  @override
  Widget build(BuildContext context) {
    List<Product> productList = [];
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("orders")
        .child(order.orderId)
        .child("productList");

    return SafeArea(
      child: FutureBuilder(
        future: databaseReference.once(),
        builder: (context, snapShot) {
          try {
            if (snapShot.hasData) {
              Map<dynamic, dynamic> map = snapShot.data.value;
              productList.clear();
              OrderDetailsVariables.grandTotal = 0;
              OrderDetailsVariables.itemTotal = 0;


              map.forEach((key, value) {
                if (value["productStatus"] != null && value["productStatus"]) {
                  OrderDetailsVariables.itemTotal += value["productTotalCartCost"];
                }
                productList.add(new Product(
                    productId: key,
                    productName: value["productName"],
                    productImage: value["productImage"],
                    productCategory: value["productCategory"],
                    productUnit: value["productUnit"],
                    productSellingPrice: value["productSellingPrice"],
                    productQuantity: value["productQuantity"],
                    productCartCount: value["productCartCount"],
                    productStatus: value["productStatus"],
                    productTotalCartCost: value["productTotalCartCost"]));
              });

              productList.sort((a,b)=>a.productName.toLowerCase().compareTo(b.productName.toLowerCase()));
              OrderDetailsVariables.orderedProductList = productList;

              return Details(
                  order: order, notifyOrderScreen: notifyOrderScreen);
            }
          } catch (e) {
            print(e);
            return Center(child: Text("Some error Occurred"));
          }
          return Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
