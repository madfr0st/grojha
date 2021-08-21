import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';

class PlaceOrderVariables {
  static int itemTotal = 0;
  static int uniqueitems = 0;
  static int delivery = 50;
  static int grandTotal = delivery+itemTotal;
  static BuildContext buildContext;
  static List<Product> list = [];
  static Shop shop;
  static String userName;
  static String userPhoneNumber;
  static String userAddress;

  PlaceOrderVariables(){
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("pincode/700001/deliveryCharge");
    databaseReference.once().then((value){
      try {
        if (value.value != null) {
          delivery = value.value;
        }
      }
      catch(e){
        print(e);
        delivery = 50;
      }
    });
  }

}