import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';

class AcceptedModifiedOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;

  AcceptedModifiedOrder({this.order}){
    this.order.userId = uid;
  }

  void acceptModifiedOrder(){
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
      "uniqueItems": order.uniqueItems,
      "orderImage":order.orderImage,
    });
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
      "uniqueItems": order.uniqueItems,
      "orderImage":order.orderImage,
    });
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
      "uniqueItems": order.uniqueItems,
      "orderImage":order.orderImage,
    });
  }

}
