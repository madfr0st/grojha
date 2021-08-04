
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);
  static String routeName = "/cart_screen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",style: TextStyle(
        color: Colors.black
    ),),
    elevation: 15,
    backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
