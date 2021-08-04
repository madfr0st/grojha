import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/single_shop//components/body.dart';
import 'package:grojha/screens/single_shop/components/product_categories.dart';
import 'package:grojha/size_config.dart';

class SingleShop extends StatelessWidget {
  final Shop shop;

  const SingleShop({
    Key key, this.shop,
  }) : super(key: key);

  static String routeName = "/single_shop";

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(
       shop: shop,
      ),
      floatingActionButton: CustomFloatingButton(shop: shop,),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key key, this.shop,
  }) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(80),
      width: getProportionateScreenWidth(160),
      alignment: Alignment.topCenter,
      //color: Colors.red,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: getProportionateScreenWidth(49),
            width: getProportionateScreenWidth(159),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple.withOpacity(1),
                  Colors.red.withOpacity(1),
                ],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Container(
            height: getProportionateScreenWidth(45),
            width: getProportionateScreenWidth(155),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Material(
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 16,
                          child: ProductCategories(shop:shop,),
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.dashboard_outlined,
                      color: Colors.black,
                      size: getProportionateScreenWidth(20),
                    ),
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
