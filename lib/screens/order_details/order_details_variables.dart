import 'package:flutter/cupertino.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';


class OrderDetailsVariables extends ChangeNotifier{
  static int itemTotal = 0;
  static Map<String,int> modifiedOrderItemTotal = {};
  static List<Product> modifiedProductIdList = [];
  static int grandTotal = 0;
  static int deliveryCharge = 0;
  static BuildContext buildContext;
  static List<Product> orderedProductList = [];
  static Shop shop;
  static String userName;
  static String userPhoneNumber;
  static String userAddress;
 // static Set<String> boolSet = {};
  static Map<String,int> modifiedAddedProductCartCount = {};
  static Set<Product> modifiedProductSet = {};

  void notifyParent(){
    notifyListeners();
  }
  static void reset(){
    modifiedOrderItemTotal.clear();
    modifiedProductIdList.clear();
    modifiedAddedProductCartCount.clear();
    modifiedProductSet.clear();
  }
}