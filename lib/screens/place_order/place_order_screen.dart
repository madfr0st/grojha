
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';

import '../../constants.dart';
import 'components/body.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({Key key, this.shop, this.notifyHomeScreen,}) : super(key: key);

  static String routeName = "/place_order_screen";
  final Function notifyHomeScreen;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.shopName,style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),

      ),
      body: Body(shop: shop,notifyHomeScreen: notifyHomeScreen,),
    );
  }
}
