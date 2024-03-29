import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../../constants.dart';
import 'components/body.dart';

class PendingOrderDetailsScreen extends StatelessWidget {
  const PendingOrderDetailsScreen({Key key, this.order, this.notifyOrderScreen}) : super(key: key);
  final Function notifyOrderScreen;


  static String routeName = "/pending_order_details_screen";
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Order Details",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),

      ),
      body: Body(order: order,notifyOrderScreen: notifyOrderScreen,),
    );
  }
}
