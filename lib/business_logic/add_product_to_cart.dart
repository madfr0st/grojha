import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';

class AddProductToCart {
  static void addProductToCart(
      {int productCartCount, Shop shop, Product product}) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("cart");
    if (productCartCount == 0) {
      databaseReference.child(shop.shopId).child(product.productId).set({});
    } else {
      databaseReference.child(shop.shopId).child(product.productId).set({
        "productCartCount": productCartCount,
        "productTotalCartCost":
            (productCartCount * product.productSellingPrice),
        "shopCategory": shop.shopCategory,
        "shopImage": shop.shopImage,
        "shopName": shop.shopName,
        "productName": product.productName,
        "productImage": product.productImage,
        "productQuantity": product.productQuantity,
        "productSellingPrice": product.productSellingPrice,
        "productUnit": product.productUnit,
        "productMRP":product.productMRP,
      });
    }
  }

  static int getProductCountToCart({Shop shop, Product product}) {

    int count = 0;

  }
}
