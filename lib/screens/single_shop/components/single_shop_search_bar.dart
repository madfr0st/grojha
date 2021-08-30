import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/business_logic/FCM.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/searched_data/searched_product_data.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SingleShopSearchBar extends StatefulWidget {
  final Shop shop;
  final Function notifyHomeScreen;

  const SingleShopSearchBar({Key key, this.shop, this.notifyHomeScreen})
      : super(key: key);

  @override
  _SingleShopSearchBarState createState() => _SingleShopSearchBarState();
}

class _SingleShopSearchBarState extends State<SingleShopSearchBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: getProportionateScreenWidth(5),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Container(
                width: SizeConfig.screenWidth * 0.7,
                padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.greenAccent.withOpacity(1),
                      kPrimaryColor.withOpacity(1),
                      Color(0xff34783b),
                    ],
                  ),
                ),
                child: Material(
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: SearchedProductData(
                            shop: widget.shop,
                            notifyHomeScreen: widget.notifyHomeScreen,
                          ),);
                      },
                      child: Container(
                        width: SizeConfig.screenWidth * 0.55,
                        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                Text(
                                  "Search products in this shop",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14), height: 1),
                                ),
                              ],
                            )),
                      ),
                    ))),
            Spacer(),
            IconBtnWithCounter(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),

              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      notifyHomeScreen: widget.notifyHomeScreen,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
          ],
        ),
        // SizedBox(
        //   height: getProportionateScreenWidth(5),
        // ),
      ],
    );
  }
}
