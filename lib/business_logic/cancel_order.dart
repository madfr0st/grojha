import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';

import 'change_order_state.dart';

class CancelOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;

  CancelOrder({Order this.order}){
    this.order.userId = uid;
  }

  void cancelOrder(){
    _removeOrderFromOrderDatabase();
    _removeOrderFromShopDatabase();
    _removeOrderFromUserDatabase();
    _setOrderToUserDatabase();
    _setOrderToShopDatabase();
    _setOrderToOrderDatabase();
  }

  void _removeOrderFromUserDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(order.userId)
        .child("orders/${order.orderState}")
        .child(order.orderId);
    databaseReference.set({});
  }
  void _setOrderToUserDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(order.userId)
        .child("orders/cancelled")
        .child(order.orderId);
    ChangeOrderState(this.order,databaseReference,"cancelled");
  }
  void _removeOrderFromShopDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(order.shopId)
        .child("orders/${order.orderState}")
        .child(order.orderId);
    databaseReference.set({});
  }
  void _setOrderToShopDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(order.shopId)
        .child("orders/cancelled")
        .child(order.orderId);
    ChangeOrderState(this.order,databaseReference,"cancelled");
  }
  void _removeOrderFromOrderDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001")
        .child("orders/${order.orderState}")
        .child(order.orderId);
    print(databaseReference.path);
    databaseReference.set({});  }
  void _setOrderToOrderDatabase(){
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001")
        .child("orders/cancelled")
        .child(order.orderId);
    ChangeOrderState(this.order,databaseReference,"cancelled");
  }

}
