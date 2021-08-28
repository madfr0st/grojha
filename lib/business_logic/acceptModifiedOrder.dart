import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/cancel_order.dart';

import 'FCM.dart';

class AcceptedModifiedOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;
  int removedCount = 0;

  AcceptedModifiedOrder({this.order}) {
    this.order.userId = uid;
  }

  void acceptModifiedOrder() {
    _removeOutOfStockProducts();
  }

  void _removeOrderFromUserDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(order.userId)
        .child("orders/${order.orderState}")
        .child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToUserDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(order.userId)
        .child("orders/pending")
        .child(order.orderId);
    databaseReference.set({
      "orderId": order.orderId,
      "orderState": "pending",
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
      "secondaryOrderId": order.secondaryOrderId,
      "uniqueItems": order.uniqueItems - removedCount,
      "orderImage": order.orderImage,
    });
  }

  void _removeOrderFromShopDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(order.shopId)
        .child("orders/${order.orderState}")
        .child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToShopDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("shops")
        .child(order.shopId)
        .child("orders/pending")
        .child(order.orderId);
    databaseReference.set({
      "orderId": order.orderId,
      "orderState": "pending",
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
      "secondaryOrderId": order.secondaryOrderId,
      "uniqueItems": order.uniqueItems - removedCount,
      "orderImage": order.orderImage,
    });
  }

  void _removeOrderFromOrderDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001")
        .child("orders/${order.orderState}")
        .child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToOrderDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001")
        .child("orders/pending")
        .child(order.orderId);
    databaseReference.set({
      "orderId": order.orderId,
      "orderState": "pending",
      "orderTime": ServerValue.timestamp,
      "shopId": order.shopId,
      "shopName": order.shopName,
      "deliveryCharge": order.deliveryCharge,
      "grandTotal": order.grandTotal,
      "userId": order.userId,
      "userName": order.userName,
      "userPhoneNumber": order.userPhoneNumber,
      "userAddress": order.userAddress,
      "shopImage": order.shopImage,
      "secondaryOrderId": order.secondaryOrderId,
      "uniqueItems": order.uniqueItems - removedCount,
      "orderImage": order.orderImage,
    });
  }

  void _removeOutOfStockProducts() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("orders")
        .child(order.orderId)
        .child("productList");

    databaseReference.once().then((snapShot) {
      if (snapShot.value != null) {
        Map<dynamic, dynamic> map = snapShot.value;

        print(map);

        map.forEach((key, value) {
          print(value);
          print(value["productStatus"]);
          if (value["productStatus"] != null && !value["productStatus"]) {
            databaseReference.child(key.toString()).set({});
            removedCount++;
          }
        });
      }
      if (removedCount != order.uniqueItems) {
        _removeOrderFromOrderDatabase();
        _removeOrderFromShopDatabase();
        _removeOrderFromUserDatabase();
        _setOrderToUserDatabase();
        _setOrderToShopDatabase();
        _setOrderToOrderDatabase();

        FCM().sendNotification(
            notifications: new Notifications(
          title: "Order Cancelled",
          body:
              "Order with order id #${_sixDigitOrderNumber(order.secondaryOrderId.toString())} worth ₹ ${order.grandTotal}/- has been cancelled.",
          senderId: order.userId,
          receiverId: order.shopId,
          receiverType: "shops",
          senderType: "users",
        ));
      } else {
        CancelOrder(order: order).cancelOrder();
      }
    });
  }

  String _sixDigitOrderNumber(String string) {
    int size = string.length;
    for (int i = size; i < 6; i++) {
      string = "0" + string;
    }
    return string;
  }
}
