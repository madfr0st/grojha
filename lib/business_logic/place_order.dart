import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/orders.dart';

class PlaceOrder {
  String uid = FirebaseAuth.instance.currentUser.uid;

  Order order;

  PlaceOrder({Order this.order}){
    this.order.userId = uid;
  }

  void pushOrder() {
    this.order.orderId = _getOrderKey();

    _setOrderInOrders();
    _setOrderInShopAccount();
    _setOrderInUserAccount();
    _setProductList();

    _clearCart(shopUid: order.shopId);
    //_success();
  }

  void _clearCart({String shopUid}) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart")
        .child(shopUid);

    databaseReference.set({});
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
      "orderImage":order.orderImage,
      "secondaryOrderId": ServerValue.timestamp,

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
      "orderImage":order.orderImage,
      "secondaryOrderId": ServerValue.timestamp,
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
      "orderImage":order.orderImage,
      "secondaryOrderId": ServerValue.timestamp,
    });
  }

  void _setProductList() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("orders/${this.order.orderId}/productList");
    for (int i = 0; i < order.productList.length; i++) {
      databaseReference.push().set({
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
