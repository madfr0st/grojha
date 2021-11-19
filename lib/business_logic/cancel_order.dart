import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/Objects/orders.dart';

import 'FCM.dart';
import 'change_order_state.dart';

class CancelOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;

  CancelOrder({this.order}){
    this.order.userId = uid;
  }

  void cancelOrder({bool notifySeller,bool notifyDeliveryPartner}){
    _removeOrderFromOrderDatabase();
    _removeOrderFromShopDatabase();
    _removeOrderFromUserDatabase();
    _setOrderToUserDatabase();
    _setOrderToShopDatabase();
    _setOrderToOrderDatabase();
    _setOrderTimestamp();
    notifySeller = true;
    if(notifySeller!=null && notifySeller) {
      FCM().sendNotification(
          notifications: new Notifications(
            title: "Order Cancelled",
            body:
            "Order id #${_sixDigitOrderNumber(order.secondaryOrderId.toString())} has been cancelled by customer.",
            senderId: order.userId,
            receiverId: order.shopId,
            receiverType: "shops",
            senderType: "users",
          ));
    }
    if(notifyDeliveryPartner!=null && notifyDeliveryPartner){
      FCM().sendNotification(
          notifications: new Notifications(
            title: "Order Cancelled",
            body:
            "Order with order id #${_sixDigitOrderNumber(
                order.secondaryOrderId.toString())} worth ₹ ${order
                .grandTotal}/- has been cancelled.",
            senderId: order.userId,
            receiverId: order.deliveryPartnerId,
            receiverType: "deliveryPartners",
            senderType: "users",
          ));
    }
  }


  String _sixDigitOrderNumber(String string) {
    int size = string.length;
    for (int i = size; i < 6; i++) {
      string = "0" + string;
    }
    return string;
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

  void _setOrderTimestamp() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("timeline/orders/${this.order.orderId}");
    databaseReference.push().set({
      "orderState": "cancelled",
      "time": ServerValue.timestamp,
    });
  }

}
