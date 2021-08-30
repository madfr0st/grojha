import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/check_order_state.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/order_details/accepted_order_details/accepted_order_details_screen.dart';
import 'package:grojha/screens/order_details/cancelled_order_details/cancelled_order_details_screen.dart';
import 'package:grojha/screens/order_details/delivered_order_details/delivered_order_details_screen.dart';
import 'package:grojha/screens/order_details/failed_order_details/failed_order_details_screen.dart';
import 'package:grojha/screens/order_details/modified_order_details/modified_order_details_screen.dart';
import 'package:grojha/screens/order_details/packed_order_details/packed_order_details_screen.dart';
import 'package:grojha/screens/order_details/pending_order_details/pending_order_details_screen.dart';
import 'package:grojha/screens/order_details/rejected_order_details/rejected_order_details_screen.dart';
import 'package:grojha/screens/order_details/shipped_order_details/shipped_order_details_screen.dart';

import '../../../size_config.dart';

class SingleOrderCard extends StatefulWidget {
  const SingleOrderCard({Key key, this.order, this.notifyOrderScreen})
      : super(key: key);
  final Function notifyOrderScreen;
  final Order order;

  @override
  _SingleOrderCardState createState() => _SingleOrderCardState();
}

class _SingleOrderCardState extends State<SingleOrderCard> {
  Map<String, Color> colorMap = {
    "pending": Color(0xff0f55aa),
    "packed": Color(0xffff0098),
    "accepted": Color(0xff03a7ff),
    "shipped": Colors.purple,
    "delivered": Color(0xff0faa26),
    "rejected": Colors.black,
    "failed": Colors.orange,
    "cancelled": Colors.brown,
    "modified": Colors.redAccent,
  };

  Map<String, String> orderStateName = {
    "pending": "Pending",
    "packed": "Packed",
    "accepted": "Accepted",
    "shipped": "Out For Delivery",
    "delivered": "Delivered",
    "rejected": "Rejected",
    "failed": "Failed",
    "cancelled": "Cancelled",
    "modified": "Modified",
  };

  Color color;

  @override
  Widget build(BuildContext context) {
    color = colorMap[widget.order.orderState];
    return GestureDetector(
        onTap: () => orderDetailsPage(),
        child: Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: getProportionateScreenWidth(141),
            width: double.infinity,
            //color: Colors.redAccent,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ], color: color, borderRadius: BorderRadius.circular(10)),
            child: Container(
                height: getProportionateScreenWidth(141),
                width: double.infinity,
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(28),
                      // color: Colors.tealAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Order Id: ",
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.w800,
                                  //fontStyle: FontStyle.italic,
                                  fontSize: getProportionateScreenWidth(14),
                                ),
                              ),
                              TextSpan(
                                text: "#${_orderNumber(widget.order.secondaryOrderId.toString())}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  //fontStyle: FontStyle.italic,
                                  fontSize: getProportionateScreenWidth(14),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: getProportionateScreenWidth(140),
                            height: getProportionateScreenWidth(30),
                            //color: Colors.blue,
                            child: Row(
                              children: [
                                Container(
                                  height: getProportionateScreenWidth(11),
                                  width: getProportionateScreenWidth(11),
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(5),
                                ),
                                Text(
                                  orderStateName[widget.order.orderState],
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(15),
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                      height: 1.2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: getProportionateScreenWidth(79),
                      // color: Colors.tealAccent,
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: getProportionateScreenWidth(79),
                            width: getProportionateScreenWidth(175),
                            padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                            // color: Colors.red,
                            child: Row(children: [
                              Container(
                                height: getProportionateScreenWidth(62),
                                width: getProportionateScreenWidth(62),
                                padding: EdgeInsets.all(
                                    getProportionateScreenWidth(1)),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey.shade300,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: (widget.order.orderImage != null)
                                      ? Image.network(widget.order.orderImage)
                                      : Image.asset(
                                          "assets/images/default.jpg"),
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Container(
                                //     color: Colors.redAccent,
                                height: getProportionateScreenWidth(50),
                                //width: getProportionateScreenWidth(105),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("${widget.order.uniqueItems} Item"),
                                    Text(
                                      "₹ ${widget.order.grandTotal}",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getProportionateScreenWidth(15)),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: getProportionateScreenWidth(115),
                            height: getProportionateScreenWidth(33),
                            alignment: Alignment.center,
                            //padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                            decoration: BoxDecoration(
                                color: colorMap[widget.order.orderState],
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Container(
                              width: getProportionateScreenWidth(112),
                              height: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Material(
                                borderRadius: BorderRadius.circular(7),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(7),
                                  onTap: () => orderDetailsPage(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Order Details",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(13),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            height: 1.1),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: getProportionateScreenWidth(12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: getProportionateScreenWidth(20),
                      //color: Colors.tealAccent,
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            timesStampToDate(widget.order.orderTime),
                            style: TextStyle(
                              //color: Colors.grey,
                              fontWeight: FontWeight.w800,
                              fontSize: getProportionateScreenWidth(12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  String _orderNumber(String string){
    int size = string.length;
    for(int i=size;i<6;i++){
      string = "0"+string;
    }
    return string;
  }

  String timesStampToDate(int timestamp) {
    Map<String, String> monthMap = {
      "1": "Jan",
      "2": "Feb",
      "3": "Mar",
      "4": "Apr",
      "5": "May",
      "6": "Jun",
      "7": "Jul",
      "8": "Aug",
      "9": "Sep",
      "10": "Oct",
      "11": "Nov",
      "12": "Dec",
    };
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    int hours = date.hour;
    String minutes = date.minute.toString();
    int quo = hours - 12;
    String extension = "am";
    if (quo >= 0) {
      extension = "pm";
      hours -= 12;
    }

    String hr = hours.toString();

    if (minutes.length == 1) {
      minutes = "0" + minutes;
    }

    if (hours.toString().length == 1) {
      hr = "0" + hr;
    }

    String time = day +
        "/" +
        monthMap[month] +
        "/" +
        year +
        "    " +
        hr +
        ":" +
        minutes +
        " " +
        extension;

    return time.toString();
  }

  Future<void> orderDetailsPage() async {
    bool orderState = await CheckOrderState(order: widget.order).check();
    if (orderState) {
      if (widget.order.orderState == "pending") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PendingOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "modified") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ModifiedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "accepted") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AcceptedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "packed") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PackedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "shipped") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShippedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "delivered") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeliveredOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "rejected") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RejectedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "cancelled") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CancelledOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
      if (widget.order.orderState == "failed") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FailedOrderDetailsScreen(
                  order: widget.order,
                  notifyOrderScreen: widget.notifyOrderScreen,
                )));
      }
    } else {
      widget.notifyOrderScreen();
    }

  }
}
