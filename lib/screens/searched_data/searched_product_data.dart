import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';

class SearchedProductData extends SearchDelegate<String> {
  Shop shop;
  final Function notifyHomeScreen;

  List<Product> emptyList = [AllProductData.productList[0]];

  SearchedProductData({Shop this.shop, this.notifyHomeScreen});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Product> suggestionList = query.isEmpty
        ? []
        : AllProductData.productList.where((element) {
            if (element.productName
                .toLowerCase()
                .startsWith(query.toLowerCase())) {
              return true;
            }
            if (element.productName
                .toLowerCase()
                .contains(query.toLowerCase())) {
              return true;
            }

            return false;
          }).toList();

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate((suggestionList.length>100)?100:suggestionList.length, (index) {
          return SingleProductCard(
            notifyHomeScreen: notifyHomeScreen,
            product: suggestionList[index],
            shop: shop,
          );
        })
      ]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestionList = query.isEmpty
        ? []
        : AllProductData.productList.where((element) {
            if (element.productName
                .toLowerCase()
                .startsWith(query.toLowerCase())) {
              return true;
            }
            if (element.productName
                .toLowerCase()
                .contains(query.toLowerCase())) {
              return true;
            }

            return false;
          }).toList();

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate((suggestionList.length>100)?100:suggestionList.length, (index) {
          return SingleProductCard(
            notifyHomeScreen: notifyHomeScreen,
            product: suggestionList[index],
            shop: shop,
          );
        })
      ]),
    );
  }
}
