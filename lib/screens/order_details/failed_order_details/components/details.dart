import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/failed_order_details/components/single_order_details_product_card.dart';
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
                SizedBox(height: getProportionateScreenHeight(10),),
                ...List.generate(
                  OrderDetailsVariables.list.length,
                  (index) => SingleOrderDetailsProductcard(
                    product: OrderDetailsVariables.list[index],
                    order: widget.order,
                    notifyParent: _refresh,
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
