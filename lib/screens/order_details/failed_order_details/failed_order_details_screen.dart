import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../constants.dart';
import 'components/body.dart';

class FailedOrderDetailsScreen extends StatelessWidget {
  const FailedOrderDetailsScreen({Key key, this.order, this.notifyParent}) : super(key: key);

  static String routeName = "/failed_order_details_screen";
  final Order order;
  final Function notifyParent;

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
      body: Body(order: order,),
    );
  }
}