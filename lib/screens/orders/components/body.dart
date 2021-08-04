import 'package:flutter/material.dart';
import 'package:grojha/screens/orders/components/all_orders.dart';
import 'package:grojha/screens/orders/components/single_order_card.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        AllOrders(),
      ],
    ));
  }
}
