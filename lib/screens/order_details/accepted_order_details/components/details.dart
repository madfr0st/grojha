import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/single_order_details_product_card_without_switch.dart';
import 'package:grojha/size_config.dart';

import 'order_details_footer.dart';
import '../../order_details_variables.dart';

class Details extends StatefulWidget {
  const Details({Key key, this.order, this.notifyOrderScreen}) : super(key: key);

  final Order order;
  final Function notifyOrderScreen;

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
    OrderDetailsVariables.grandTotal = 0;
    OrderDetailsVariables.itemTotal = 0;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Instruction(),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                ...List.generate(
                  OrderDetailsVariables.list.length,
                  (index) => SingleOrderDetailsProductcardWithoutSwitch(
                    product: OrderDetailsVariables.list[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                  ),
                ),
                OrderDetailsFooter(
                  order: widget.order,notifyOrderScreen: _refresh,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Instruction extends StatelessWidget {
  const Instruction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      child: Text(
        "Your order has been accepted by seller.\n Soon, he will be packing your order.",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
