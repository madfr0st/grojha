import 'package:grojha/Objects/product.dart';

class Order {
  String orderId;
  int uniqueItems;
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
  int acceptanceCode;
  String orderImage;
  int secondaryOrderId;
  String deliveryPartnerId;

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
    String this.orderImage, int this.uniqueItems,this.deliveryPartnerId});

  @override
  String toString() {
    return 'Order{orderState: $orderState}';
  }
}