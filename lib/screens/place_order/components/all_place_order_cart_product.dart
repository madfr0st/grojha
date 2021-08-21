import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/components/place_order_footer.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import 'package:grojha/screens/place_order/components/single_place_order_product_card.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';

class AllPlaceOrderCartProduct extends StatefulWidget {
  const AllPlaceOrderCartProduct({
    Key key,
    this.shop, this.notifyHomeScreen,
  }) : super(key: key);
  final Shop shop;
  final Function notifyHomeScreen;

  @override
  _AllPlaceOrderCartProduct createState() =>
      _AllPlaceOrderCartProduct();
}

class _AllPlaceOrderCartProduct extends State<AllPlaceOrderCartProduct> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<Product> list = [];
  int grandTotal = 0;


  _refresh() {
    setState(() {});
    widget.notifyHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart")
        .child(widget.shop.shopId);


    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: databaseReference.once(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data.value);
                  try {
                    Map<dynamic, dynamic> values = snapshot.data.value;
                    list.clear();
                    PlaceOrderVariables.itemTotal = 0;
                    values.forEach((key, value) {
                      list.add(new Product(
                          productId: key,
                          productName: value["productName"],
                          productImage: value["productImage"],
                          productCategory: value["productCategory"],
                          productUnit: value["productUnit"],
                          productSellingPrice: value["productSellingPrice"],
                          productQuantity: value["productQuantity"],
                          productCartCount: value["productCartCount"],
                          productTotalCartCost: value["productTotalCartCost"]));
                    });
                    PlaceOrderVariables.list = list;
                    PlaceOrderVariables.shop = widget.shop;

                    PlaceOrderVariables.list.sort((a,b)=>a.productName.compareTo(b.productName));

                    return Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(children: [
                            ...List.generate(list.length, (index) {
                              PlaceOrderVariables.itemTotal +=
                                  list[index].productTotalCartCost;
                              return SinglePlaceOrderProductCard(
                                shop: widget.shop,
                                product: list[index],
                                notifyHomeScreen: _refresh,
                              );
                            })
                          ]),
                        ),
                      ),
                      PlaceOrderFooter(
                        notifyHome: _refresh,
                        product: PlaceOrderVariables.list[0],
                        uniqueItems: list.length,
                      ),
                    ]);
                  } catch (e) {
                    print(e);
                    return Center(child: Text("Cart is EMPTY!!!"));
                  }
                }
                return Center(child : CircularProgressIndicator());
              }),
        ),
      ],
    );
  }

  int toInt(String a) {
    var myInt = int.parse(a);
    assert(myInt is int);
    return myInt;
  }
}
