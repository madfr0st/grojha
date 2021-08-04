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
      this.productImage = "https://picsum.photos/250?image=9";
  }

  @override
  String toString() {
    return 'Product{productId: $productId, productName: $productName, productImage: $productImage, productCategory: $productCategory, productUnit: $productUnit, productSellingPrice: $productSellingPrice, productMRP: $productMRP, productStatus: $productStatus, productQuantity: $productQuantity, productCartCount: $productCartCount, productTotalCartprice: $productTotalCartCost}';
  }
}
