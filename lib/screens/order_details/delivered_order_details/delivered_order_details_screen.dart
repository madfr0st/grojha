import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../constants.dart';
import 'components/body.dart';

class DeliveredOrderDetailsScreen extends StatelessWidget {
  const DeliveredOrderDetailsScreen({Key key, this.order, this.notifyOrderScreen}) : super(key: key);

  static String routeName = "/delivered_order_details_screen";
  final Order order;
  final Function notifyOrderScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivered Order Details",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),

      ),
      body: Body(order: order,),
    );
  }
}
