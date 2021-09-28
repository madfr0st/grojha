import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/all_shops.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.selectedCategory, this.notifyHomeScreen})
      : super(key: key);

  final String selectedCategory;
  final Function notifyHomeScreen;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Shop> list = [];

  final scrollController = ScrollController();

  int _currentViewItem = 20;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    for (int i = 0; i < AllShopData.list.length; i++) {
      if (AllShopData.list[i].shopCategory == widget.selectedCategory) {
        list.add(AllShopData.list[i]);
      }
    }
    if (_currentViewItem > list.length) {
      _currentViewItem = list.length;
    }
    return SafeArea(
      child: Container(
          child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //controller: scrollController,
                itemCount: _currentViewItem,
                itemBuilder: (context, index) {
                  return SingleShopCard(
                      notifyHomeScreen: widget.notifyHomeScreen,
                      shop: list[index],
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleShop(
                                shop: list[index],
                                notifyHomeScreen: widget.notifyHomeScreen,
                              ),
                            ));
                      });
                }),
            SizedBox(height: getProportionateScreenWidth(80),),
            (_currentViewItem != list.length)
                ? CircularProgressIndicator(
                    color: kPrimaryColor,
                  )
                : Instructions.banner_1("That's all", kPrimaryColor),
            SizedBox(
              height: getProportionateScreenWidth(40),
            ),
          ],
        ),
      )),
    );
  }

  void _loadMore() {
    if (_currentViewItem < list.length) {
      _currentViewItem += 20;
    }
    if (_currentViewItem > list.length) {
      _currentViewItem = list.length;
    }
    setState(() {});
  }
}
