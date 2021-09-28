import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/components/Instructions.dart';
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

  final scrollController = ScrollController();

  int _currentViewItem = 20;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadMore();
      }
    });
    super.initState();
  }

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
                        controller: scrollController,
                        child: Column(children: [
                          Column(
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  //controller: scrollController,
                                  itemCount: _currentViewItem,
                                  itemBuilder: (context, index) {
                                    return SingleOrderCard(
                                      order: orderList[index],
                                      notifyOrderScreen: _refresh,
                                    );
                                  }),
                              SizedBox(
                                height: getProportionateScreenWidth(80),
                              ),
                              (_currentViewItem != orderList.length)
                                  ? CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    )
                                  : Instructions.banner_1(
                                      "That's all", kPrimaryColor),
                              SizedBox(
                                height: getProportionateScreenWidth(20),
                              ),
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
                return Center(
                    child: Instructions.banner_1("Zero Orders", kPrimaryColor));
              }
            }
            return Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
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

    if (_currentViewItem > orderList.length) {
      _currentViewItem = orderList.length;
    }
  }

  void _loadMore() {
    if (_currentViewItem < orderList.length) {
      _currentViewItem += 20;
    }
    if (_currentViewItem > orderList.length) {
      _currentViewItem = orderList.length;
    }
    setState(() {});
  }
}
