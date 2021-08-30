
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key, this.notifyHomeScreen}) : super(key: key);
  static String routeName = "/cart_screen";
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",style: TextStyle(
        color: Colors.black,
            fontWeight: FontWeight.bold
    ),),

      ),
      body: Body(notifyHomeScreen: notifyHomeScreen,),
    );
  }
}
