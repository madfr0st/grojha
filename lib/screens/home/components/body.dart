import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'all_shops.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AllShops(),
      //AllShops(),
      //SizedBox(height: getProportionateScreenWidth(30)),
    );
  }
}
