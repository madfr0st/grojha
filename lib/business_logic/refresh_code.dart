import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';

class RefreshCode {
  Order order;
  int code;

  RefreshCode({Order this.order, int this.code});

  String uid = FirebaseAuth.instance.currentUser.uid;

  void refreshCode() {
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
