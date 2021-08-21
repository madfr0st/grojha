import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/single_order_details_product_card_without_switch.dart';
import 'package:grojha/size_config.dart';

import 'order_details_footer.dart';
import '../../order_details_variables.dart';

class Details extends StatefulWidget {
  const Details({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  void _refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    OrderDetailsVariables.grandTotal = 0;
    OrderDetailsVariables.itemTotal = 0;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTopInstruction(),
                SizedBox(height: getProportionateScreenHeight(10),),
                ...List.generate(
                  OrderDetailsVariables.list.length,
                  (index) => SingleOrderDetailsProductcardWithoutSwitch(
                    product: OrderDetailsVariables.list[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                  ),
                ),
                OrderDetailsFooter(order: widget.order,),
                //SizedBox(height: getProportionateScreenHeight(10),),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildTopInstruction(){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Text(
        "Your order has been packed by seller.\nSoon, delivery partner will be assign.",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

}
