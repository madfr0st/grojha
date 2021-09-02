import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../constants.dart';
import 'components/body.dart';

class ShippedOrderDetailsScreen extends StatelessWidget {
  const ShippedOrderDetailsScreen({Key key, this.order, this.notifyOrderScreen}) : super(key: key);

  static String routeName = "/shipped_order_details_screen";
  final Order order;
  final Function notifyOrderScreen;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Out For Delivery Order Details",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),

      ),
      body: Body(order: order,notifyOrderScreen: notifyOrderScreen,),
    );
  }
}
