import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

import '../../../size_config.dart';
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

    //databaseReference.push().set({"value":"check"});

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Shops near by",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          child: FutureBuilder(
              future: databaseReference.once(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    //print(snapshot.data.value);
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  shops.clear();
                  values.forEach((key, value) {
                    if (value["info"]["shopName"] != null) {
                      shops.add(new Shop(
                          shopName: value["info"]["shopName"],
                          shopCategory: value["info"]["shopCategory"],
                          shopId: key,
                          shopAddress: value["info"]["shopAddress"],
                          shopImage: value["info"]["shopImage"]));
                    }
                  });
                  //print(shops);

                  AllShopData.list = shops;

                    return Column(children: [
                      ...List.generate(shops.length, (index) {
                        return SingleShopCard(
                            shop: shops[index],
                            press: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleShop(
                                      shop: shops[index]
                                    ),
                                  ));
                            });
                      })
                    ]);
                  } catch (e) {
                    print(e);
                    return Text("Some Error Occured!!!");
                  }
                }
                return CircularProgressIndicator();
              }),
        ),
      ],
    );
  }
}
