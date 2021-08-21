import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/screens/single_selected_product_category/SingleSelectedProductCategory.dart';
import 'package:grojha/size_config.dart';

class ProductCategories extends StatelessWidget {
  final Shop shop;
  const ProductCategories({
    Key key, this.shop, this.notifyHomeScreen,
  }) : super(key: key);
  final Function notifyHomeScreen;
  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    list = AllProductData.categoryList;
    List<Color> color_list = [
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.red,
      Colors.indigo,
      Colors.brown,
      Colors.amber,
      Colors.grey,
      Colors.teal,
      Colors.pink,
      Colors.amberAccent,
      Colors.lightGreenAccent,
      Colors.cyan,
      Colors.yellowAccent,
      Colors.tealAccent,
      Colors.pinkAccent,
      Colors.green.shade700,
      Colors.red.shade700,
      Colors.amber,
      Colors.grey,
    ];
    final _random = new Random();

    int size = list.length;
    if (size % 2 == 0) {
      var s = size / 2;
      size = calc_ranks(s);
      return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              ...List.generate(
                  size,
                  (index) => CategoryCardRow(
                      list[index],
                      list[index + size],
                      color_list[_random.nextInt(color_list.length)],
                      color_list[_random.nextInt(color_list.length)])),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      );
    } else {
      var s = size / 2;
      size = calc_ranks(s);
      return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              ...List.generate(
                  size,
                  (index) => CategoryCardRow(
                      list[index],
                      list[index + size],
                      color_list[_random.nextInt(color_list.length)],
                      color_list[_random.nextInt(color_list.length)])),
              CategoryCardRow1(list[2 * size],
                  color_list[_random.nextInt(color_list.length)]),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      );
    }
  }

  int calc_ranks(ranks) {
    return ranks.floor();
  }

  Padding CategoryCardRow(
      String name1, String name2, Color color1, Color color2) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleProductCategories(
            name: name1,
            color: color1,
            shop: shop,
            notifyHomeScreen: notifyHomeScreen,
          ),
          SingleProductCategories(
            name: name2,
            color: color2,
            shop: shop,
            notifyHomeScreen: notifyHomeScreen,
          ),
        ],
      ),
    );
  }

  Padding CategoryCardRow1(String name1, Color color1) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleProductCategories(
            name: name1,
            color: color1,
            shop: shop,
            notifyHomeScreen: notifyHomeScreen,
          ),
        ],
      ),
    );
  }
}

class SingleProductCategories extends StatelessWidget {
  const SingleProductCategories({
    Key key,
    this.color,
    this.name,
    this.shop, this.notifyHomeScreen,
  }) : super(key: key);

  final Color color;
  final String name;
  final Shop shop;
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth * .18,
      width: SizeConfig.screenWidth * .3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        height: SizeConfig.screenWidth * .18,
        width: SizeConfig.screenWidth * .3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(1),
              color.withOpacity(0),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: SizeConfig.screenWidth * .18 - getProportionateScreenWidth(4),
          width: SizeConfig.screenWidth * .3 - getProportionateScreenWidth(4),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => SingleSelectedProductCategory(
                    productCategory: name,
                    shop: shop,
                    notifyHomeScreen: notifyHomeScreen,
                  ),
                ));
              },
              child: Container(
                height: SizeConfig.screenWidth * .18 -
                    getProportionateScreenWidth(4),
                width: SizeConfig.screenWidth * .3 -
                    getProportionateScreenWidth(4),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                decoration: BoxDecoration(
                  //color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.8),
                      color.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      //Text(text, textAlign: TextAlign.cente
    );
  }
}
