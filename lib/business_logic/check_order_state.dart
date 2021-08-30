

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';


class CheckOrderState {
  Order order;

  CheckOrderState({this.order});

  Future<bool> check() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users/$uid/orders/${order.orderState}/${order.orderId}");
    return databaseReference.once().then((value) {
      if (value.value != null) {
        return true;
      }
      return false;
    });
  }
}
