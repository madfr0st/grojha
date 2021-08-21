import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/modified_order_details/components/single_order_details_product_card.dart';
import 'package:grojha/size_config.dart';

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
                  (index) => SingleOrderDetailsProductCard(
                    product: OrderDetailsVariables.list[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                  ),
                ),
                OrderDetailsFooter(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
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
        "Due to limited stock.\nYour order has been modified by seller.",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
