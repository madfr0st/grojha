import 'package:grojha/Objects/product.dart';

class Order {
  String orderId;
  String totalItem;
  String shopId;
  String userId;
  int grandTotal;
  int deliveryCharge;
  String shopName;
  String userName;
  String userAddress;
  String userPhoneNumber;
  String shopPhoneNumber;
  String shopImage;
  int orderTime;
  String orderState;
  List<Product> productList;
  String orderImage;
  int secondaryOrderId;

  Order({String this.shopId,
    String this.shopName,
    String this.shopPhoneNumber,
    String this.userPhoneNumber,
    String this.userName,
    String this.userId,
    String this.userAddress,
    String this.shopImage,
    int this.grandTotal,
   int this.orderTime,
    String this.orderId,
    String this.orderState,
    int this.deliveryCharge,
    int this.secondaryOrderId,
    List<Product> this.productList,
    String this.orderImage});

  @override
  String toString() {
    return 'Order{orderId: $orderId, totalItem: $totalItem, shopId: $shopId, userId: $userId, grandTotal: $grandTotal, deliveryCharge: $deliveryCharge, shopName: $shopName, userName: $userName, userPhoneNumber: $userPhoneNumber, shopPhoneNumber: $shopPhoneNumber, orderTime: $orderTime, orderState: $orderState, product: $productList}';
  }
}