import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/screens/orders/components/single_order_card.dart';
import 'package:grojha/size_config.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  List<Order> orderList = [];

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;

    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("orders");

    void _refresh() {
      setState(() {});
    }

    return Expanded(
      child: FutureBuilder(
          future: databaseReference.once(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                //print(snapshot.data.value);
                _logic(snapshot.data);
                return RefreshIndicator(
                  color: kPrimaryColor,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Column(
                        children: [
                          ...List.generate(orderList.length, (index) {
                            return SingleOrderCard(
                              order: orderList[index],
                              notifyOrderScreen: _refresh,
                            );
                          }),
                          SizedBox(
                            height: SizeConfig.screenHeight,
                          )
                        ],
                      )
                    ])),
                    onRefresh: () {
                      return databaseReference.once().then((value) {
                        _logic(value);
                        setState(() {});
                      });
                    });
              } catch (e) {
                print(e);
                return Center(child: Text("Some Error Occurred!!!"));
              }
            }
            return Center(child: CircularProgressIndicator(color: kPrimaryColor,));
          }),
    );
  }

  void _logic(DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;

    orderList.clear();
    values.forEach((key, val) {
      val.forEach((key, value) {
        orderList.add(new Order(
          orderId: value["orderId"],
          orderState: value["orderState"],
          orderTime: value["orderTime"],
          shopId: value["shopId"],
          shopName: value["shopName"],
          deliveryCharge: value["deliveryCharge"],
          grandTotal: value["grandTotal"],
          userId: value["userId"],
          userName: value["userName"],
          userPhoneNumber: value["userPhoneNumber"],
          userAddress: value["userAddress"],
          uniqueItems: value["uniqueItems"],
          secondaryOrderId: value["secondaryOrderId"],
          orderImage: value["orderImage"],
        ));
      });
    }); //print(s// hops);

    orderList.sort((a, b) => -a.orderTime.compareTo(b.orderTime));
  }
}
