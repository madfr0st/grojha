import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/modified_order_details/components/single_order_details_product_card.dart';
import 'package:grojha/size_config.dart';

import '../../Instructions.dart';
import 'order_details_footer.dart';
import '../../order_details_variables.dart';

class Details extends StatefulWidget {
  const Details({Key key, this.order, this.notifyOrderScreen}) : super(key: key);
  final Function notifyOrderScreen;

  final Order order;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void _refresh() {
    widget.notifyOrderScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    OrderDetailsVariables.modifiedOrderItemTotal[widget.order.orderId] = OrderDetailsVariables.itemTotal;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Instructions.orderStateBanner(
                  " Due to limited stock.\nYour order has been modified by seller.",
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Instructions.orderNumberBanner(widget.order.secondaryOrderId.toString()),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                ...List.generate(
                  OrderDetailsVariables.orderedProductList.length,
                  (index) => SingleOrderDetailsProductCard(
                    product: OrderDetailsVariables.orderedProductList[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                    productNumber: index + 1,
                  ),
                ),
                OrderDetailsFooter(
                  order: widget.order,
                  notifyOrderScreen: _refresh,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
