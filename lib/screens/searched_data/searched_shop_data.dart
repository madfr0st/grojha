import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

class SearchedShopData extends SearchDelegate<String> {
  List<String> list = ["checl", "csd", "adad", "adad"];

  List<Shop> emptyList = [
    new Shop(
        shopName: "No Result",
        shopAddress: "No Result",
        shopCategory: "No Result")
  ];

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
        icon: Icon(Icons.search_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Shop> suggestionList = query.isEmpty
        ? []
        : AllShopData.list.where((element){
      if (element.shopName.startsWith(query)) {
        return true;
      }
      if(element.shopName.toLowerCase().startsWith(query)) {
        return true;
      }
      if(element.shopName.toUpperCase().startsWith(query)) {
        return true;
      }

      if(element.shopName.contains(query)) {
        return true;
      }
      if(element.shopName.toUpperCase().contains(query)) {
        return true;
      }
      // if(element.productName.toUpperCase().matchAsPrefix(query) != null) {
      //   return true;
      // }


      return false;

    }).toList();

    return SingleChildScrollView(
      child: Column(children: [
        ...List.generate(suggestionList.length, (index) {
          return SingleShopCard(
            shop: suggestionList[index],
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleShop(
                        shop: suggestionList[index]
                    ),
                  ));
            } ,
          );
        })
      ]),
    );
  }
}
