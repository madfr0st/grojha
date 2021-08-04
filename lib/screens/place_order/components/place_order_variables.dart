import 'package:flutter/cupertino.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';

class PlaceOrderVariables {
  static int itemTotal = 0;
  static int delivery = 20;
  static int grandTotal = delivery+itemTotal;
  static BuildContext buildContext;
  static List<Product> list = [];
  static Shop shop;
  static String userName;
  static String userPhoneNumber;
  static String userAddress;

}