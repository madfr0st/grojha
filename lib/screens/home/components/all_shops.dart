import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';
import 'section_title.dart';

class AllShops extends StatefulWidget {
  const AllShops({Key key}) : super(key: key);

  @override
  _AllShopsState createState() => _AllShopsState();
}

class _AllShopsState extends State<AllShops> {
  List<Shop> shops;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("pincode/700001/shops");

  @override
  Widget build(BuildContext context) {
    shops = [];

    void _refresh() {
      setState(() {});
    }

    return FutureBuilder(
        future: databaseReference.once(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              //print(snapshot.data.value);
              Map<dynamic, dynamic> values = snapshot.data.value;
              shops.clear();
              values.forEach((key, value) {
                try {
                  if (value["info"]["shopName"] != null &&
                      value["status"]["open"]) {
                    shops.add(new Shop(
                        shopName: value["info"]["shopName"],
                        shopCategory: value["info"]["shopCategory"],
                        shopId: key,
                        shopAddress: value["info"]["shopAddress"],
                        shopImage: value["info"]["shopImage"]));
                  }
                } catch (e) {
                  print(e);
                }
              });
              //print(shops);

              AllShopData.list = shops;

              return Column(children: [
                SizedBox(height: getProportionateScreenHeight(5)),
                HomeHeader(
                  notifyHomeScreen: _refresh,
                ),
                SizedBox(height: getProportionateScreenWidth(5)),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  Categories(notifyHomeScreen: _refresh),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SectionTitle(
                      title: "Shops near by",
                      press: () {},
                    ),
                  ),
                  ...List.generate(shops.length, (index) {
                    return SingleShopCard(
                        shop: shops[index],
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleShop(
                                  shop: shops[index],
                                  notifyHomeScreen: _refresh,
                                ),
                              ));
                        });
                  }),
                ])))
              ]);
            } catch (e) {
              print(e);
              return Center(child: Text("Some Error Occured!!!"));
            }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
