import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class CartItemCount {
  static  int cartItemCount = 0;

  static Map<String,int> map = {};

  static Future<bool> init() async {

    var event;

    getCartItemCount(once: true);

    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("users/$uid/cart");
    event = await databaseReference.once().then((DataSnapshot dataSnapshot){
      if(dataSnapshot.value!=null){
        String shopId;
        cartItemCount = 0;
        Map<dynamic,dynamic> map1 = dataSnapshot.value;
        map1.forEach((key, value) {
          shopId = key.toString();
          value.forEach((key,val){
            map[shopId+key] = val["productCartCount"];
            cartItemCount++;
          });
        });
      }
      else{
        cartItemCount = 0;
      }
      return true;
    });

    return event;
  }

  static void increaseItemCount({int itemCount, Function notifyHome}) {
    if (itemCount == null) {
      itemCount = 0;
    }
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users/$uid/cartItemCount");
    databaseReference.runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0) + itemCount;
      if(notifyHome!=null){
        notifyHome();
      }
      return transaction;
    });
  }

  static void decreaseItemCount({int itemCount, Function notifyHome}) {
    if (itemCount == null) {
      itemCount = 0;
    }
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child("users/$uid/cartItemCount");
    databaseReference.runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0) - itemCount;
      if(notifyHome!=null){
        notifyHome();
      }
      return transaction;
    });
  }

  static int getCartItemCount({Function notifyHome,bool once}) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child("users/$uid/cartItemCount");
    databaseReference.runTransaction((MutableData transaction) async {
      transaction.value = (transaction.value ?? 0);
      if(once){
        transaction.value = cartItemCount;
      }
      cartItemCount = transaction.value;
      if(notifyHome!=null){
        notifyHome();
      }
      return transaction;
    });
  }
}
