import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../../constants.dart';
import 'components/body.dart';

class PendingOrderDetailsScreen extends StatelessWidget {
  const PendingOrderDetailsScreen({Key key, this.order, this.notifyParent}) : super(key: key);
  final Function notifyParent;


  static String routeName = "/pending_order_details_screen";
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Order Details",style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(order: order,notifyParent: notifyParent,),
    );
  }
}
