
import 'package:flutter/material.dart';
import 'package:grojha/screens/orders/components/single_order_card.dart';

class BodyAll extends StatefulWidget {
  const BodyAll({Key key}) : super(key: key);

  @override
  _BodyAllState createState() => _BodyAllState();
}

class _BodyAllState extends State<BodyAll> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Column(
        children: [
          SingleOrderCard(),
          SingleOrderCard(),
          SingleOrderCard(),
          SingleOrderCard(),
          SingleOrderCard(),
          SingleOrderCard(),
        ],
      ),
    ),);
  }
}
