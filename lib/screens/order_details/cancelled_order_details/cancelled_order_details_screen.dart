import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../constants.dart';
import 'components/body.dart';

class CancelledOrderDetailsScreen extends StatelessWidget {
  const CancelledOrderDetailsScreen({Key key, this.order, this.notifyOrderScreen}) : super(key: key);

  static String routeName = "/cancelled_order_details_screen";
  final Order order;
  final Function notifyOrderScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancelled Order Details",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(order: order,),
    );
  }
}
