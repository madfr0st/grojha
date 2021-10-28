import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/get_notifications.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/global_variables/all_shop_data.dart';
import 'package:grojha/screens/home/components/single_shop_card.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';
import 'package:new_version/new_version.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';
import 'section_title.dart';

class AllShops extends StatefulWidget {
  const AllShops({Key key}) : super(key: key);
  static bool showUpdate = true;
  @override
  _AllShopsState createState() => _AllShopsState();
}

class _AllShopsState extends State<AllShops> {
  List<Shop> shops;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("pincode/700001/shops");

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
    shops = [];

    void _refresh() {
      setState(() {});
    }

    if(AllShops.showUpdate) {
      NewVersion(
        context: context,
        androidId: 'com.grojha.grojha',
      ).showAlertIfNecessary();
      AllShops.showUpdate = false;
    }

    return FutureBuilder(
        future: databaseReference.once(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              _logic(snapshot.data);

              return RefreshIndicator(
                  child: Column(children: [
                    SizedBox(height: getProportionateScreenHeight(5)),
                    HomeHeader(
                      notifyHomeScreen: _refresh,
                    ),
                    SizedBox(height: getProportionateScreenWidth(5)),
                    Expanded(
                        child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(children: [
                              Categories(notifyHomeScreen: _refresh),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(20)),
                                child: SectionTitle(
                                  title: "Shops near by",
                                  press: () {},
                                ),
                              ),
                              SizedBox(height: getProportionateScreenWidth(10)),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  //controller: scrollController,
                                  itemCount: _currentViewItem,
                                  itemBuilder: (context, index) {
                                    return SingleShopCard(
                                        shop: shops[index],
                                        press: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SingleShop(
                                                  shop: shops[index],
                                                  notifyHomeScreen: _refresh,
                                                ),
                                              ));
                                        });
                                  }),
                              SizedBox(height: getProportionateScreenWidth(80),),
                              (_currentViewItem!=AllShopData.list.length)?CircularProgressIndicator(color: kPrimaryColor,): Instructions.banner_1("That's all", kPrimaryColor),
                              SizedBox(height: getProportionateScreenWidth(20),),
                            ])))
                  ]),
                  color: kPrimaryColor,
                  onRefresh: () {
                    return databaseReference.once().then((value) {
                      _logic(value);
                      setState(() {});
                    });
                  });
            } catch (e) {
              print(e);
              return Center(child: Text("Some Error Occurred!!!"));
            }
          }
          return Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          ));
        });
  }

  void _logic(DataSnapshot snapshot) {
    GetNotifications();
    Map<dynamic, dynamic> values = snapshot.value;
    shops.clear();
    values.forEach((key, value) {
      try {
        if (value["info"]["shopName"] != null && value["status"]["open"]) {
          shops.add(new Shop(
              shopName: value["info"]["shopName"],
              shopCategory: value["info"]["shopCategory"],
              shopId: key,
              shopAddress: value["info"]["shopAddress"],
              shopImage: value["info"]["shopImage"]));
        }
      } catch (e) {
        print(e);
      }
    });
    //print(shops);

    AllShopData.list = shops;
    if(_currentViewItem>shops.length){
      _currentViewItem = shops.length;
    }
  }

  void _loadMore() {
    if (_currentViewItem < AllShopData.list.length) {
      _currentViewItem += 20;
    }
    if (_currentViewItem > AllShopData.list.length) {
      _currentViewItem = AllShopData.list.length;
    }
    setState(() {});
  }
}
