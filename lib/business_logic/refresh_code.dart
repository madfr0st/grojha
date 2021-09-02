import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/check_order_state.dart';
import 'package:grojha/components/event_status.dart';

class RefreshCode {
  Order order;
  int code;
  BuildContext context;
  //Function notifyParent;

  RefreshCode({Order this.order, int this.code,this.context});

  String uid = FirebaseAuth.instance.currentUser.uid;

  Future<void> refreshCode({Function notifyParent}) async {
    if (await CheckOrderState(order: order).check()) {
      FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(order.userId)
          .child("orders/shipped")
          .child(order.orderId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value != null) {
          _setOrderToUserDatabase();
          _setOrderToShopDatabase();
          _setOrderToOrderDatabase();
        }
      });
    } else {
      EventStatus(context: context,popScreen: 2).success(notifyParent: notifyParent);
    }
  }

  void _setOrderToUserDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(order.userId)
        .child("orders/shipped")
        .child(order.orderId);
    databaseReference.update({
      "acceptanceCode": code,
    });
  }

  void _setOrderToShopDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(order.shopId)
        .child("orders/shipped")
        .child(order.orderId);
    databaseReference.update({
      "acceptanceCode": code,
    });
  }

  void _setOrderToOrderDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001")
        .child("orders/shipped")
        .child(order.orderId);
    databaseReference.update({
      "acceptanceCode": code,
    });
  }
}
