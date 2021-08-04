import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/components/all_place_order_cart_product.dart';
import 'package:grojha/screens/place_order/components/place_order_footer.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.shop}) : super(key: key);
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    PlaceOrderVariables.buildContext = context;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AllPlaceorderCartProduct(shop: shop),
          )
        ],
      ),
    );
  }
}
