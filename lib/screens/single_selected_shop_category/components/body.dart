import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/all_shops.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.selectedCategory}) : super(key: key);

  final String selectedCategory;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Shop> list = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < AllShopData.list.length; i++) {
      if (AllShopData.list[i].shopCategory == widget.selectedCategory) {
        list.add(AllShopData.list[i]);
      }
    }
    return SafeArea(
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(list.length, (index) {
              return SingleShopCard(
                  shop: list[index],
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleShop(
                            shop: list[index],
                          ),
                        ));
                  });
            })
          ],
        ),
      )),
    );
  }
}
