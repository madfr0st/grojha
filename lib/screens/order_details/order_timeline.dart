import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/size_config.dart';

class OrderTimeLine extends StatefulWidget {
  const OrderTimeLine({Key key, this.order}) : super(key: key);

  final Order order;

  @override
  _OrderTimeLineState createState() => _OrderTimeLineState();
}

class _OrderTimeLineState extends State<OrderTimeLine> {
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
    "pending": "Order Placed",
    "packed": "Order Packed",
    "accepted": "Order Accepted",
    "shipped": "Out For Delivery",
    "delivered": "Order Delivered",
    "rejected": "Order Rejected",
    "failed": "order Failed",
    "cancelled": "Order Cancelled",
    "modified": "Order Modified",
  };

  List<OrderTimestamp> list = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Column(
        children: [
          singleOrderTimeLine("pending","21/05/2021 10:54 AM"),
          singleOrderTimeLine("accepted","21/05/2021 10:54 AM"),
          singleOrderTimeLine("packed","21/05/2021 10:54 AM"),
          singleOrderTimeLine("shipped","21/05/2021 10:54 AM"),
          singleOrderTimeLine("delivered","21/05/2021 10:54 AM"),

          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
        ],
      ),
    );
  }

  Container singleOrderTimeLine(String orderState, String time) {
    return Container(
          height: getProportionateScreenWidth(30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(.2),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: Offset(3, 3), // changes position of shadow
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                //color: Colors.grey,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(40),
                      width: getProportionateScreenWidth(2),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(1000),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: getProportionateScreenWidth(15),
                      width: getProportionateScreenWidth(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: colorMap[orderState],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              Container(
                child: Text(
                  orderStateName[orderState],
                  style: TextStyle(color: colorMap[orderState], fontWeight: FontWeight.bold, fontSize: getProportionateScreenWidth(14),height: 1.1),
                ),
              ),
              Spacer(),
              Container(
                child: Text(time,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: getProportionateScreenWidth(12),height: 1.1)),
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
            ],
          ),
        );
  }

  Future<void> _logic() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("timeline/orders/${widget.order.orderId}");

    await databaseReference.once().then((value){
      if(value!=null){
        try{
          list.clear();
          Map<dynamic,dynamic> map = value.value;
          map.forEach((key, val) {
            list.add(OrderTimestamp(val["orderState"], val["time"]));
          });


          list.sort((a,b)=>-a.time.compareTo(b.time));
          return true;

        }
        catch(e){
          print(e);
        }
      }
    });

    return false;
  }
}

class OrderTimestamp{
  String orderState;
  int time;

  OrderTimestamp(this.orderState, this.time);

}