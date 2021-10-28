

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/components/custom_button.dart';
import 'package:grojha/screens/order_details/single_order_details_product_card_without_switch.dart';
import 'package:grojha/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants.dart';
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
                Instructions.orderStateBanner("Your order has been placed successfully"),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Instructions.orderNumberBanner(widget.order.secondaryOrderId.toString()),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                ...List.generate(
                  OrderDetailsVariables.orderedProductList.length,
                  (index) => SingleOrderDetailsProductcardWithoutSwitch(
                    productNumber: index + 1,
                    product: OrderDetailsVariables.orderedProductList[index],
                    order: widget.order,
                    notifyOrderScreen: _refresh,
                  ),
                ),
                OrderDetailsFooter(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                ),
                support(),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Container support(){
    return Container(
      height: getProportionateScreenWidth(60),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(getProportionateScreenWidth(10),0, getProportionateScreenWidth(10), getProportionateScreenWidth(30)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.screenWidth*.7,
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(12),
                ),
                children: [
                  TextSpan(text: 'If this order have been not accepted in 15 minutes, please call '),
                  TextSpan(
                    text: '+91-74398-52955.',
                    style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ),
          _call(text:"7439852955")
        ],
      ),
    );
  }
  Container _call({String text}) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      alignment: Alignment.centerLeft,
      height: getProportionateScreenWidth(30),
      width: getProportionateScreenWidth(60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      //      color: Colors.grey
      child: Material(
        borderRadius: BorderRadius.circular(1000),
        color: Colors.green,
        child: InkWell(
          borderRadius: BorderRadius.circular(1000),
          onTap: () {
            _launchURL("tel:+91"+text);
          },
          child: Container(
            height: 1000,
            width: 1000,
            child: Icon(Icons.call,color: Colors.white,),
          ),
        ),
      ),
    );
  }
  void _launchURL(String text) async => await canLaunch(text)
      ? await launch(text)
      : throw 'Could not launch $text';
}
