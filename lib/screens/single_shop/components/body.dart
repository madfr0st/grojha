import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/components/product_categories.dart';
import 'package:grojha/screens/single_shop/components/products_list.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';
import 'package:grojha/screens/single_shop/components/single_shop_details.dart';
import 'package:grojha/screens/single_shop/components/single_shop_search_bar.dart';
import 'package:grojha/size_config.dart';

import 'menu_title.dart';

class Body extends StatelessWidget {
  final Shop shop;
  final Function notifyHomeScreen;

  const Body({Key key, this.shop, this.notifyHomeScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProductsList(shop: shop, notifyHomeScreen: notifyHomeScreen),
    );
  }
}
