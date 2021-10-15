import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/business_logic/cart_item_count.dart';

import 'FCM.dart';

class PlaceOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;
  int orderNumber;

  PlaceOrder({this.order}) {
    this.order.userId = uid;
  }

  void pushOrder() async {
    _orderNumber();
  }

  void _orderNumber() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("orderNumber");

    databaseReference.runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0) + 1;
      orderNumber = transaction.value;
      return transaction;
    }).then((value) {
      if (orderNumber != null) {
        this.order.orderId = _getOrderKey();
        _setOrderInOrders();
        _setOrderInShopAccount();
        _setOrderInUserAccount();
        _setProductList();
        FCM().sendNotification(
            notifications: new Notifications(
          title: "New order",
          body:
              "You have received a new order #${_sixDigitOrderNumber(orderNumber.toString())} of value ${order.grandTotal}/-",
          senderId: order.userId,
          receiverId: order.shopId,
          receiverType: "shops",
          senderType: "users",
        ));

        clearCart(shopUid: order.shopId);
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

  void clearCart({String shopUid}) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart")
        .child(shopUid);

    databaseReference.set({});
    CartItemCount.cartItemCount -= order.productList.length;
    CartItemCount.decreaseItemCount(itemCount: order.productList.length);

    for (int i = 0; i < order.productList.length; i++) {
      CartItemCount.map[order.shopId + order.productList[i].productId] = 0;
    }
  }

  String _getOrderKey() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("orders/700001/pending/");

    String orderKey = databaseReference.push().key;

    print(orderKey);
    return orderKey;
  }

  void _setOrderInUserAccount() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users/$uid/orders/pending/${this.order.orderId}");

    databaseReference.set({
      "orderId": order.orderId,
      "orderState": order.orderState,
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
      "orderImage": order.orderImage,
      "secondaryOrderId": orderNumber,
      "uniqueItems": order.uniqueItems
    });
  }

  void _setOrderInShopAccount() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child(
            "shops/${this.order.shopId}/orders/pending/${this.order.orderId}");

    databaseReference.set({
      "orderId": order.orderId,
      "orderState": order.orderState,
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
      "orderImage": order.orderImage,
      "secondaryOrderId": orderNumber,
      "uniqueItems": order.uniqueItems
    });
  }

  void _setOrderInOrders() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("pincode/700001/orders/pending/${this.order.orderId}");

    databaseReference.set({
      "orderId": order.orderId,
      "orderState": order.orderState,
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
      "orderImage": order.orderImage,
      "secondaryOrderId": orderNumber,
      "uniqueItems": order.uniqueItems
    });
  }

  void _setProductList() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("orders/${this.order.orderId}/productList");
    for (int i = 0; i < order.productList.length; i++) {
      databaseReference.child(order.productList[i].productId).set({
        "productId": order.productList[i].productId,
        "productImage": order.productList[i].productImage,
        "productUnit": order.productList[i].productUnit,
        "productQuantity": order.productList[i].productQuantity,
        "productName": order.productList[i].productName,
        "productTotalCartCost": order.productList[i].productTotalCartCost,
        "productCartCount": order.productList[i].productCartCount,
        "productMRP": order.productList[i].productMRP,
        "productSellingPrice": order.productList[i].productSellingPrice,
        "productStatus": true,
      });
    }
  }
}
