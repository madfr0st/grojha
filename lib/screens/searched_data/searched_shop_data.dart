import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

class SearchedShopData extends SearchDelegate<String> {
  List<Shop> emptyList = [
    new Shop(
        shopName: "No Result",
        shopAddress: "No Result",
        shopCategory: "No Result")
  ];

  final Function notifyHomeScreen;

  SearchedShopData({Function this.notifyHomeScreen});

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
    final List<Shop> suggestionList = query.isEmpty
        ? []
        : AllShopData.list.where((element) {
            if (element.shopName
                .toLowerCase()
                .startsWith(query.toLowerCase())) {
              return true;
            }
            if (element.shopName.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (element.shopName.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }

            return false;
          }).toList();

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(suggestionList.length, (index) {
          return SingleShopCard(
            notifyHomeScreen: notifyHomeScreen,
            shop: suggestionList[index],
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleShop(
                      shop: suggestionList[index],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ));
            },
          );
        })
      ]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Shop> suggestionList = query.isEmpty
        ? []
        : AllShopData.list.where((element) {
            if (element.shopName
                .toLowerCase()
                .startsWith(query.toLowerCase())) {
              return true;
            }
            if (element.shopName.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (element.shopName.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }

            return false;
          }).toList();

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(suggestionList.length, (index) {
          return SingleShopCard(
            notifyHomeScreen: notifyHomeScreen,
            shop: suggestionList[index],
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleShop(
                      shop: suggestionList[index],
                      notifyHomeScreen: notifyHomeScreen,
                    ),
                  ));
            },
          );
        })
      ]),
    );
  }
}
