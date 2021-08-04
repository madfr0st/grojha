import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';

import '../../../size_config.dart';
import 'menu_title.dart';

class ProductsList extends StatefulWidget {
  final Shop shop;

  const ProductsList({Key key, this.shop}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    shopId = widget.shop.shopId;
    databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(shopId)
        .child("products");

    return Container(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: databaseReference.once(),
            builder: (context, snapshot) {
              try {
                if (snapshot.hasData) {
                  //print(snapshot.data.value);
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  products.clear();
                  map.clear();
                  count = 0;
                  categoryList.clear();

                  values.forEach((key, value) {
                    // print("\n");
                    // print(values);
                    // print("\n");
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

                    if (map.containsKey(value["productCategory"])) {
                      map[value["productCategory"]].add(product);
                    } else {
                      count++;
                      map[value["productCategory"]] = [];
                      map[value["productCategory"]].add(product);
                      categoryList.add(value["productCategory"]);
                    }

                    products.add(product);
                  });


                  AllProductData.categoryList = categoryList;
                  AllProductData.productList = products;

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: count,
                      itemBuilder: (context, i) {
                        return new ExpansionTile(
                            title: MenuTitle(title: categoryList[i]),
                            children: [
                              ...List.generate(map[categoryList[i]].length, (index) {
                                return SingleProductCard(
                                  product: map[categoryList[i]][index],
                                  shop: widget.shop,
                                );
                              }),
                            ]);
                      });
                }
              } catch (e) {
                print(e);
                return Center(
                  child: Text("Zero products Added"),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  String calcPercentage(String num, String den) {
    try {
      var a = int.parse(num);
      assert(a is int);
      int b = int.parse(den);
      assert(b is int);
      int c = a * 100;
      var d = (c / b);
      c = d.toInt();
      c = 100 - c;
      return "$c";
    } catch (e) {
      //print("error while %");
      return "0";
    }
  }
}
