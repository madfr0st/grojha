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
      "Kirana & Grocery",
      "Fruits",
      "Vegetable",
      "Chicken",
      "Fish",
      "Meat",
      "Sweets",
      "Bakery & Cake",
      "Restaurants",
      "Paan Shop",
      "Dairy",
      "Medicine",
      "Puja",
      "Stationery",
      "Books",
      "Electronics & Appliances",
      "Laptop & PCs",
      "Mobile",
      "Utensils & Plastic",
      "Hardware",
      "Gifts & Toys",
      "Footwear",
      "Clothing",
      "Cosmetics"
    ];

    List<Color> colorList = [
      Colors.green,
      Colors.orange,
      Colors.lightGreenAccent,
      Colors.purple,
      Colors.lightBlueAccent,
      Colors.red,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.indigo,
      Colors.greenAccent,
      Colors.amber,
      Colors.redAccent,
      Colors.teal,
      Colors.pink,
      Colors.amberAccent,
      Colors.lightGreenAccent,
      Colors.cyan,
      Colors.blue,
      Colors.tealAccent,
      Colors.pinkAccent,
      Colors.green.shade700,
      Colors.red.shade700,
      Colors.purple,
      Colors.grey,
    ];

    List<String> imageList = [
      "assets/images/grocery_1.jpg",
      "assets/images/fruits_1.jpg",
      "assets/images/vegetables_1.jpg",
      "assets/images/chicken.jpg",
      "assets/images/fish_1.jpg",
      "assets/images/meat_1.jpg",
      "assets/images/sweets.jpg",
      "assets/images/bakery_1.jpg",
      "assets/images/resturants_1.jpg",
      "assets/images/paan_1.png",
      "assets/images/dairy_1.jpg",
      "assets/images/medicine.jpg",
      "assets/images/puja_1.jpg",
      "assets/images/stationary_1.jpg",
      "assets/images/books_1.jpg",

      "assets/images/electronics_1.jpeg",
      "assets/images/laptop_1.jpg",
      "assets/images/mobile.jpg",
      "assets/images/utensils_1.jpg",
      "assets/images/hardware_1.jpg",
      "assets/images/gifts.jpg",
      "assets/images/footwear.jpg",
      "assets/images/clothing.jpg",
      "assets/images/cosmetics_1.jpg"
    ];

    //list.sort((a,b)=> a.compareTo(b));

    int at = 0;

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
                8,
                (index) => CategoryCardRow(
                    at++, at++, at++, list, colorList, context, imageList))
          ],
        ),
      ),
    );
  }

  Padding CategoryCardRow(int a, int b, int c, List<String> list,
      List<Color> color, BuildContext context, List<String> imageList) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryCard(
              text: list[a],
              color: Colors.transparent,
              image: imageList[a],
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
              color: Colors.transparent,
              image: imageList[b],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSelectedShopCategory(
                      selectedCategory: list[b],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ))),
          CategoryCard(
              text: list[c],
              color: Colors.transparent,
              image: imageList[c],
              press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleSelectedShopCategory(
                      selectedCategory: list[c],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  )))
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
    this.image,
  }) : super(key: key);

  final String text;
  final Color color;
  final GestureTapCallback press;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: SizeConfig.screenWidth * .28,
        width: SizeConfig.screenWidth * .28,
        padding: EdgeInsets.all(getProportionateScreenWidth(3)),
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(0.2), BlendMode.lighten),
                    image: AssetImage(image),
                  ),
                ),
              ),
              Container(
                height: SizeConfig.screenWidth * .28,
                width: SizeConfig.screenWidth * .28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      color.withOpacity(.7),
                      color.withOpacity(.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: press,
                  child: Container(
                      height: SizeConfig.screenWidth * .28,
                      width: SizeConfig.screenWidth * .28,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),

      //Text(text, textAlign: TextAlign.cente
    );
  }
}
