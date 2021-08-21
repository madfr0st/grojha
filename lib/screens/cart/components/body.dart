
import 'package:flutter/material.dart';
import 'package:grojha/screens/cart/components/all_shop_cart.dart';
import 'package:grojha/screens/cart/components/single_shop_cart_card.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.notifyHomeScreen}) : super(key: key);
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AllShopCart(notifyHomeScreen: notifyHomeScreen,),
        ],
      ),
    );
  }
}
