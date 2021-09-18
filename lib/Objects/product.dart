import 'dart:ui';
import 'package:flutter/material.dart';

class Product {
  String productId;
  String productName;
  String productImage;
  String productCategory = "Category";
  String productUnit = "Unit";
  int productSellingPrice = 0;
  int productMRP = 0;
  bool productStatus = false;
  int productQuantity;
  int productCartCount;
  int productTotalCartCost;

  Product(
      {String this.productId,
      String this.productName,
      String this.productImage,
      String this.productCategory,
      String this.productUnit,
      int this.productSellingPrice,
      this.productCartCount,
      this.productTotalCartCost,
      int this.productMRP,
      bool this.productStatus,
      int this.productQuantity}) {
    if (this.productImage == null || this.productImage.length == 0)
      this.productImage = "https://firebasestorage.googleapis.com/v0/b/project-red-117.appspot.com/o/defaultImages%2FDefaultShopImage.png?alt=media&token=bb7b949f-fb1b-42a4-ae24-22f3d8bd22fd";

    if (this.productName == null) {
      this.productName = " ";
    }
    if (this.productSellingPrice == null) {
      this.productSellingPrice = 999999999;
    }
    if (this.productMRP == null) {
      this.productMRP = 999999999;
    }
    if (this.productQuantity == null) {
      this.productQuantity = 0;
    }
    if (this.productId == null) {
      this.productId = " ";
    }
  }

  @override
  String toString() {
    return 'Product{productId: $productId, productName: $productName, productImage: $productImage, productCategory: $productCategory, productUnit: $productUnit, productSellingPrice: $productSellingPrice, productMRP: $productMRP, productStatus: $productStatus, productQuantity: $productQuantity, productCartCount: $productCartCount, productTotalCartprice: $productTotalCartCost}';
  }
}
