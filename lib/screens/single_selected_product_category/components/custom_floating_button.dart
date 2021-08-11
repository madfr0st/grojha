import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/searched_data/searched_product_data.dart';

import '../../../size_config.dart';

class CustomFloatingButton extends StatelessWidget {
  final Function function;
  final Shop shop;

  const CustomFloatingButton({
    Key key,
    this.function, this.shop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(400),
      width: getProportionateScreenWidth(300),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      alignment: Alignment.bottomRight,
      child:  Container(
        height: getProportionateScreenWidth(49),
        width: getProportionateScreenWidth(149),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(4, 4), // changes position of shadow
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
        child: Container(
          height: getProportionateScreenWidth(45),
          width: getProportionateScreenWidth(145),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                showSearch(context: context, delegate: SearchedProductData(shop: shop));
              },
              child: Container(
                height: getProportionateScreenWidth(45),
                width: getProportionateScreenWidth(145),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: getProportionateScreenWidth(20),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: Colors.black),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
