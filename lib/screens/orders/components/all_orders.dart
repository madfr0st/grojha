import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/screens/orders/components/single_order_card.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    List<Order> orderList = [];
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("orders");

    return Expanded(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: databaseReference.once(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  //print(snapshot.data.value);
                  Map<dynamic, dynamic> values = snapshot.data.value;

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

                  orderList.sort((a,b)=> -a.orderTime.compareTo(b.orderTime));

                  return Column(children: [
                    ...List.generate(orderList.length, (index) {
                      return SingleOrderCard(
                        order: orderList[index],
                      );
                    })
                  ]);
                } catch (e) {
                  print(e);
                  return Center(child: Text("Some Error Occured!!!"));
                }
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
