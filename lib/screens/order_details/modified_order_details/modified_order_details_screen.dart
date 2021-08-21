import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';


import '../../../../constants.dart';
import 'components/body.dart';

class ModifiedOrderDetailsScreen extends StatelessWidget {
  const ModifiedOrderDetailsScreen({Key key, this.order, this.notifyOrderScreen}) : super(key: key);
  final Function notifyOrderScreen;


  static String routeName = "/modified_order_details_screen";
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modified Order Details",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(order: order,notifyOrderScreen: notifyOrderScreen,),
    );
  }
}
