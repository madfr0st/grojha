import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';

import '../../../constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key key, this.order}) : super(key: key);

  static String routeName = "/order_details_screen";
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Oder Details",style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),

    );
  }
}
