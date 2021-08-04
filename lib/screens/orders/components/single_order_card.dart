import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/order_details/order_details_screen.dart';
import 'package:grojha/size_config.dart';

class SingleOrderCard extends StatefulWidget {
  const SingleOrderCard({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  _SingleOrderCardState createState() => _SingleOrderCardState();
}

class _SingleOrderCardState extends State<SingleOrderCard> {

  Map<String,Color> colorMap = {
    "pending":Color(0xff0cfda8),
    "modified":Colors.cyan,
    "accepted":Colors.blue,
    "shipped":Colors.purple,
    "delivered":Colors.green,
    "rejected":Colors.redAccent,
    "failed":Colors.orange,
    "cancelled":Colors.brown
  };

  Color color;

  @override
  Widget build(BuildContext context) {
    color = colorMap[widget.order.orderState];
    return Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: getProportionateScreenWidth(141),
        width: double.infinity,
        //color: Colors.redAccent,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            color: color, borderRadius: BorderRadius.circular(10)),
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
                      Text(
                        "#${widget.order.orderId}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          //fontStyle: FontStyle.italic,
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      ),
                      Text(
                        "Jul20 07:01 PM",
                        style: TextStyle(
                          //color: Colors.grey,
                          fontWeight: FontWeight.w800,
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getProportionateScreenWidth(70),
                 // color: Colors.tealAccent,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: getProportionateScreenWidth(70),
                        width: getProportionateScreenWidth(180),
                       // color: Colors.red,
                        child: Row(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: getProportionateScreenWidth(62),
                              width: getProportionateScreenWidth(62),
                              alignment: Alignment.center,
                              color: Colors.grey.shade300,
                              child: Container(
                                height: getProportionateScreenWidth(60),
                                width: getProportionateScreenWidth(60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/images/tshirt.png"),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                       //     color: Colors.redAccent,
                            height: getProportionateScreenWidth(50),
                            width: getProportionateScreenWidth(105),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("99 ITEMS"),
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
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(70),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFDCDBDB)),
                        child: Text(
                          "COD",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w900,
                              height: 1.2,
                              color: Colors.indigo),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: getProportionateScreenWidth(29),
                //  color: Colors.tealAccent,
                  child: Row(
                    children: [
                      Container(
                        width: getProportionateScreenWidth(100),
                        height: getProportionateScreenHeight(30),
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
                              "${widget.order.orderState}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  color: color,
                                  height: 1.2),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          width: getProportionateScreenWidth(80),
                          height: getProportionateScreenWidth(25),
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: Container(
                            width: getProportionateScreenWidth(78),
                            height: getProportionateScreenWidth(23),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetailsScreen(
                                    order: widget.order,
                                  ) ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Details",
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(13),
                                          height: 1.2),
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
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
