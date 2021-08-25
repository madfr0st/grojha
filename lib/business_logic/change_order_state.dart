import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';

class ChangeOrderState {
  DatabaseReference databaseReference;
  String newOrderState;
  Order order;

  ChangeOrderState(this.order, this.databaseReference, this.newOrderState) {
    databaseReference.set({
      "orderId": order.orderId,
      "orderState": newOrderState,
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
      "orderImage": order.orderImage,
      "deliveryPartnerId": order.deliveryPartnerId,
    });
  }
}
