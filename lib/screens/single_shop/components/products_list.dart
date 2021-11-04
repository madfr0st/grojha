import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/camel_case.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';
import 'package:grojha/screens/single_shop/components/single_shop_search_bar.dart';

import '../../../size_config.dart';
import 'menu_title.dart';

class ProductsList extends StatefulWidget {
  final Shop shop;
  final Function notifyHomeScreen;

  const ProductsList({Key key, this.shop, this.notifyHomeScreen}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Product> products = [];
  String shopId;
  DatabaseReference databaseReference;
  List<String> categoryList = [];
  Map<String, List<Product>> map = {};
  int count = 0;
  final scrollController = ScrollController();

  int _currentViewItem = 5;

  void _refresh() {
    widget.notifyHomeScreen();
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shopId = widget.shop.shopId;
    databaseReference = FirebaseDatabase.instance.reference().child("shops").child(shopId).child("products");

    List<Color> color_list = [
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.redAccent,
      Colors.indigo,
      Colors.brown,
      Colors.deepPurpleAccent,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
      Colors.pinkAccent,
      Colors.green.shade700,
      Colors.red.shade700,
      Colors.blue,
      Colors.lightGreen,
      Colors.deepOrange,
      Colors.amber,
      Colors.amberAccent
    ];
    final _random = new Random();

    return FutureBuilder(
        future: databaseReference.once(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              _logic(snapshot);
              return Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(5)),
                  SingleShopSearchBar(
                    shop: widget.shop,
                    notifyHomeScreen: _refresh,
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          MenuTitle(
                            title: widget.shop.shopName,
                            color: Colors.black,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              //controller: scrollController,
                              itemCount: _currentViewItem,
                              itemBuilder: (context, i) {
                                Color color = color_list[_random.nextInt(color_list.length)];
                                return new ExpansionTile(
                                    title: Text(
                                      CamelCase.convert(categoryList[i]),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: getProportionateScreenWidth(15),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //backgroundColor: Colors.grey.shade200,
                                    childrenPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    initiallyExpanded: true,
                                    iconColor: color.withOpacity(.7),
                                    collapsedIconColor: color,
                                    collapsedBackgroundColor: color.withOpacity(0.1),
                                    children: [
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        // controller: scrollController,
                                        itemCount: map[categoryList[i]].length,
                                        itemBuilder: (context, j) {
                                          return SingleProductCard(
                                            product: map[categoryList[i]][j],
                                            shop: widget.shop,
                                            notifyHomeScreen: _refresh,
                                          );
                                        },
                                      )
                                    ]);
                              }),
                          SizedBox(
                            height: getProportionateScreenWidth(60),
                          ),
                          (_currentViewItem != count)
                              ? CircularProgressIndicator(
                                  color: kPrimaryColor,
                                )
                              : Instructions.banner_1("That's all", kPrimaryColor),
                          SizedBox(
                            height: getProportionateScreenWidth(60),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          } catch (e) {
            print(e);
            return Center(
              child: Text("Zero products Added"),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        });
  }

  void _loadMore() {
    if (_currentViewItem < count) {
      _currentViewItem += 5;
    }
    if (_currentViewItem > count) {
      _currentViewItem = count;
    }
    setState(() {});
  }

  void _logic(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      //print(snapshot.data.value);
      Map<dynamic, dynamic> values = snapshot.data.value;
      products.clear();
      map.clear();
      count = 0;
      categoryList.clear();

      AllProductData.categoryImageMap.clear();

      values.forEach((key, value) {
        try {
          if (value["productCategory"] == null) {
            print(key);
          }
          if (value["productStatus"]) {
            Product product = new Product(
                productId: key,
                productName: value["productName"],
                productImage: value["productImage"],
                productCategory: value["productCategory"],
                productUnit: value["productUnit"],
                productSellingPrice: value["productSellingPrice"],
                productMRP: value["productMRP"],
                productStatus: value["productStatus"],
                productQuantity: value["productQuantity"]);

            if (map.containsKey(value["productCategory"] ?? " ")) {
              map[value["productCategory"] ?? " "].add(product);
            } else {
              count++;
              map[value["productCategory"] ?? " "] = [];
              map[value["productCategory"] ?? " "].add(product);
              categoryList.add(value["productCategory"] ?? " ");
              AllProductData.categoryImageMap[value["productCategory"] ?? " "] = value["productImage"];
            }

            products.add(product);
          }
        } catch (e) {
          print(e);
        }
      });

      AllProductData.categoryList = categoryList;

      AllProductData.categoryList.sort((a, b) {
        try {
          return a.toLowerCase().compareTo(b.toLowerCase());
        } catch (e) {
          print(a + " " + b);
          return -1;
        }
      });

      AllProductData.productList = products;
      AllProductData.productList.sort((a, b) => a.productName.toLowerCase().compareTo(b.productName.toLowerCase()));

      if (_currentViewItem > count) {
        _currentViewItem = count;
      }
    }
  }


}
