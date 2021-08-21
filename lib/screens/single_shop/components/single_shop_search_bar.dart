import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/global_variables/FCM.dart';
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
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(5),
            ),
            InkWell(
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
                width: SizeConfig.screenWidth * 0.7,
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                    child: Row(
                  children: [
                    //SizedBox(width: getProportionateScreenWidth(10),),
                    Icon(
                      Icons.search_outlined,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(20),
                    ),
                    Text(
                      "Search product",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(17), height: 1),
                    ),
                  ],
                )),
              ),
            ),
            IconBtnWithCounter(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: kSecondaryColor,
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
              width: getProportionateScreenWidth(5),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenWidth(5),
        ),
      ],
    );
  }
}
