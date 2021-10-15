import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/single_order_details_product_card_without_switch.dart';
import 'package:grojha/size_config.dart';

import '../../Instructions.dart';
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
                Instructions.orderStateBanner( "Your order has been rejected by seller."),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Instructions.orderNumberBanner(widget.order.secondaryOrderId.toString()),
                SizedBox(height: getProportionateScreenHeight(10),),
                ...List.generate(
                  OrderDetailsVariables.orderedProductList.length,
                  (index) => SingleOrderDetailsProductcardWithoutSwitch(
                    productNumber: index+1,
                    product: OrderDetailsVariables.orderedProductList[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                  ),
                ),
                OrderDetailsFooter(order: widget.order,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
