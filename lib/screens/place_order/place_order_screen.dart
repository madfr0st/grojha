
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';

import '../../constants.dart';
import 'components/body.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({Key key, this.shop,}) : super(key: key);

  static String routeName = "/place_order";

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.shopName,style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(shop: shop),
    );
  }
}
