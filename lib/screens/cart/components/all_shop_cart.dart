import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/cart_temp.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/cart/components/single_shop_cart_card.dart';
import '../../../../constants.dart';
class AllShopCart extends StatefulWidget {
  const AllShopCart({Key key, this.notifyHomeScreen}) : super(key: key);
  final Function notifyHomeScreen;
  @override
  _AllShopCartState createState() => _AllShopCartState();
}

class _AllShopCartState extends State<AllShopCart> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<CartTemp> list = [];
  int cartUniqueProducts = 0;
  int bannerCount = 0;
  int cartTotalCost = 0;
  String shopName;
  String shopCategory;
  String shopImage;

  @override
  Widget build(BuildContext context) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart");

    void _refresh(){
      widget.notifyHomeScreen();
      setState(() {
      });
    }

    return Column(
      children: [
        SingleChildScrollView(
          child: FutureBuilder(
              future: databaseReference.once(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data.value);
                  try {
                    Map<dynamic, dynamic> values = snapshot.data.value;
                    list.clear();
                    values.forEach((key, value) {
                      bannerCount++;
                      String shopId = key;
                      cartTotalCost = 0;
                      cartUniqueProducts = 0;
                      value.forEach((key, val) {
                        String productId = key;
                        cartTotalCost += val["productTotalCartCost"];
                        shopName = val["shopName"];
                        shopCategory = val["shopCategory"];
                        shopImage = val["shopImage"];
                        cartUniqueProducts++;
                      });
                      list.add(new CartTemp(shopId, shopName, shopCategory,
                          cartTotalCost, cartUniqueProducts, shopImage));
                    });
                    //print(shops);

                    return Column(children: [
                      ...List.generate(
                        list.length,
                        (index) {
                          return SingleShopCartCard(
                            notifyHomeScreen: _refresh,
                            index: index,
                            cartTotalCost: list[index].cartTotalProductCost,
                            cartUniqueProducts: list[index].cartUniqueProducts,
                            shop: Shop(
                              shopName: list[index].shopName,
                              shopId: list[index].shopId,
                              shopCategory: list[index].shopCategory,
                              shopImage: list[index].shopImage,
                            ),
                          );
                        },
                      )
                    ]);
                  } catch (e) {
                    print(e);
                    return Center(child: Text("Your Cart is EMPTY!!!"));
                  }
                }
                return Center(child: CircularProgressIndicator(color: kPrimaryColor,));
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
