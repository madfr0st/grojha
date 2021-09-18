import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/components/cached_image.dart';

import '../../../size_config.dart';

class SingleShopCard extends StatelessWidget {
  final Shop shop;
  final GestureTapCallback press;
  final Function notifyHomeScreen;

  const SingleShopCard({Key key, this.press, this.shop, this.notifyHomeScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: getProportionateScreenWidth(141),
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(3, 3), // changes position of shadow
        ),
      ], color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: getProportionateScreenWidth(141),
        width: double.infinity,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: press,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: getProportionateScreenWidth(102),
                    width: getProportionateScreenWidth(102),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey.shade300,
                    ),
                    child: Container(
                      height: getProportionateScreenWidth(100),
                      width: getProportionateScreenWidth(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedImage(url:shop.shopImage),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(15),
                  ),
                  Container(
                    //color: Colors.redAccent,
                    height: getProportionateScreenWidth(100),
                    width: getProportionateScreenWidth(200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          height: getProportionateScreenWidth(40),
                          //color: Colors.green,
                          child: Text(
                            shop.shopName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                //fontStyle: FontStyle.italic,
                                fontSize: getProportionateScreenWidth(16),
                                height: 1.2),
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: getProportionateScreenWidth(20),
                            //color: Colors.green,
                            child: Text(
                              shop.shopCategory,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  fontSize: getProportionateScreenWidth(15)),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: getProportionateScreenWidth(32),
                            //color: Colors.green,
                            child: Text(
                              shop.shopAddress,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: 1,
                                  fontSize: getProportionateScreenWidth(12)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
