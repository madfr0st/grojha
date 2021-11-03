import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/Objects/orders.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/business_logic/cancel_order.dart';
import 'package:grojha/screens/order_details/order_details_variables.dart';

import 'FCM.dart';

class AcceptedModifiedOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;
  int removedCount = 0;
  List<Product> orderedProductList;
  Set<Product> modifiedProductSet;
  Map<String, int> modifiedAddedProductCartCount;

  List<Product> processedList = [];
  int uniqueProducts = 0;
  int totalCartCost = 0;

  AcceptedModifiedOrder({this.order, this.modifiedAddedProductCartCount, this.modifiedProductSet, this.orderedProductList}) {
    this.order.userId = uid;
    try {
      Iterator<Product> iterator = modifiedProductSet.iterator;
      while (iterator.moveNext()) {
        Product product = iterator.current;
        if (modifiedAddedProductCartCount[order.orderId + " " + product.productId] != null &&
            modifiedAddedProductCartCount[order.orderId + " " + product.productId] > 0) {
          product.productCartCount = modifiedAddedProductCartCount[order.orderId + " " + product.productId];
          product.productTotalCartCost = modifiedAddedProductCartCount[order.orderId + " " + product.productId] * product.productSellingPrice;
          processedList.add(product);
          totalCartCost += product.productTotalCartCost;
        }
      }
      for (int i = 0; i < orderedProductList.length; i++) {
        if (orderedProductList[i].productStatus) {
          processedList.add(orderedProductList[i]);
          totalCartCost += orderedProductList[i].productTotalCartCost;
        }
      }
      order.grandTotal = totalCartCost + order.deliveryCharge;
      order.uniqueItems = processedList.length;
      print(processedList);
    } catch (e) {
      print(e);
    }
  }

  void acceptModifiedOrder() {
    _removeOutOfStockProducts();
    _clearModifiedData();
    OrderDetailsVariables.reset();
  }

  void _removeOrderFromUserDatabase() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users").child(order.userId).child("orders/${order.orderState}").child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToUserDatabase() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users").child(order.userId).child("orders/pending").child(order.orderId);
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
      "orderImage": order.orderImage,
    });
  }

  void _removeOrderFromShopDatabase() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("shops").child(order.shopId).child("orders/${order.orderState}").child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToShopDatabase() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("shops").child(order.shopId).child("orders/pending").child(order.orderId);
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
      "orderImage": order.orderImage,
    });
  }

  void _removeOrderFromOrderDatabase() {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("pincode/700001").child("orders/${order.orderState}").child(order.orderId);
    databaseReference.set({});
  }

  void _setOrderToOrderDatabase() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("pincode/700001").child("orders/pending").child(order.orderId);
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
      "orderImage": order.orderImage,
    });
  }

  Future<void> _removeOutOfStockProducts() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("orders").child(order.orderId).child("productList");

    databaseReference.set({});

    for (int i = 0; i < processedList.length; i++) {
      databaseReference.child(processedList[i].productId).set({
        "productId": processedList[i].productId,
        "productImage": processedList[i].productImage,
        "productUnit": processedList[i].productUnit,
        "productQuantity": processedList[i].productQuantity,
        "productName": processedList[i].productName,
        "productTotalCartCost": processedList[i].productTotalCartCost,
        "productCartCount": processedList[i].productCartCount,
        "productMRP": processedList[i].productMRP,
        "productSellingPrice": processedList[i].productSellingPrice,
        "productStatus": true,
      });
    }

    if (order.uniqueItems > 0) {
      _removeOrderFromOrderDatabase();
      _removeOrderFromShopDatabase();
      _removeOrderFromUserDatabase();
      _setOrderToUserDatabase();
      _setOrderToShopDatabase();
      _setOrderToOrderDatabase();

      await FCM().sendNotification(
          notifications: new Notifications(
        title: "New order",
        body: "You have received a new order #${_sixDigitOrderNumber(order.secondaryOrderId.toString())} of value ${order.grandTotal-order.deliveryCharge}/-",
        senderId: order.userId,
        receiverId: order.shopId,
        receiverType: "shops",
        senderType: "users",
      ));
      _notifyAdmin();
    } else {
      CancelOrder(order: order).cancelOrder();
    }

    // databaseReference.once().then((snapShot) {
    //   if (snapShot.value != null) {
    //     Map<dynamic, dynamic> map = snapShot.value;
    //
    //     print(map);
    //
    //     map.forEach((key, value) {
    //       print(value);
    //       print(value["productStatus"]);
    //       if (value["productStatus"] != null && !value["productStatus"]) {
    //         databaseReference.child(key.toString()).set({});
    //         removedCount++;
    //       }
    //     });
    //   }
    //
    // });
  }

  String _sixDigitOrderNumber(String string) {
    int size = string.length;
    for (int i = size; i < 6; i++) {
      string = "0" + string;
    }
    return string;
  }

  void _clearModifiedData() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("modifiedOrderDetails/${order.orderId}");
    databaseReference.set({});
  }

  Future<void> _notifyAdmin()async {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("adminDeviceId");

    await databaseReference.once().then((value) {
      if(value.value!=null){
        Map<dynamic,dynamic> map = value.value;
        map.forEach((key, value) async {
          String id = value;
          await FCM().sendNotification(
              notifications: new Notifications(
                title: "Hey Admin!!!",
                body:
                "A modified order #${_sixDigitOrderNumber(order.secondaryOrderId.toString())} of value ${order.grandTotal-order.deliveryCharge}/- has been placed.",
                senderId: order.userId,
                receiverId: order.shopId,
                receiverToken: id,
                receiverType: "shops",
                senderType: "users",
              ));
        });
      }
    });

  }
}
