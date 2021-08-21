import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grojha/screens/single_selected_shop_category/single_selected_shop_category.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  final Function notifyHomeScreen;

  const Categories({Key key, this.notifyHomeScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Kirana & Grocery ",
      "Fruits ",
      "Vegetable ",
      "Dairy",
      "Chicken",
      "Fish",
      "Meat",
      "Medicine",
      "Footwear",
      "Clothing",
      "Cosmetics",
      "Stationery",
      "Books",
      "Electronic",
      "Sweets",
      "Utensils & plastic",
      "Pan shop",
      "Laptop & pcs",
      "Mobile",
      "Restaurants ",
      "Puja ",
      "Gifts",
      "Hardware",
      "Bakery & Sweets"
    ];

    List<Color> colorList = [
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

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                8,
                (index) => CategoryCardRow(
                    index, 8 + index, 16 + index, list, colorList, context))
          ],
        ),
      ),
    );
  }

  Padding CategoryCardRow(int a, int b, int c, List<String> list,
      List<Color> color, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(
              text: list[a],
              color: color[a],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSelectedShopCategory(
                      selectedCategory: list[a],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ))),
          CategoryCard(
            text: list[b],
            color: color[b],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSelectedShopCategory(
                      selectedCategory: list[b],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ))
          ),
          CategoryCard(
            text: list[c],
            color: color[c],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSelectedShopCategory(
                      selectedCategory: list[c],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ))
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.text,
    this.color,
    this.press,
  }) : super(key: key);

  final String text;
  final Color color;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: SizeConfig.screenWidth * .25,
        width: SizeConfig.screenWidth * .28,
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
          height: SizeConfig.screenWidth * .25,
          width: SizeConfig.screenWidth * .28,
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
            height:
                SizeConfig.screenWidth * .25 - getProportionateScreenWidth(4),
            width:
                SizeConfig.screenWidth * .28 - getProportionateScreenWidth(4),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: press,
                child: Container(
                  height: SizeConfig.screenWidth * .25 -
                      getProportionateScreenWidth(4),
                  width: SizeConfig.screenWidth * .28 -
                      getProportionateScreenWidth(4),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
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
                    text,
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
      ),

      //Text(text, textAlign: TextAlign.cente
    );
  }
}
