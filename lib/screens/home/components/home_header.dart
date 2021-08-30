import 'package:flutter/material.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/components/notification_btn_with_counter.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/notification/notification_screen.dart';
import 'package:grojha/screens/profile/profile_screen.dart';
import 'package:grojha/screens/searched_data/searched_shop_data.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
    this.notifyHomeScreen,
  }) : super(key: key);
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeSearchField(
            notifyHomeScreen: notifyHomeScreen,
          ),
          Spacer(),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          NotificationBtnWithCounter(
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen(
                              notifyHomeScreen: notifyHomeScreen,
                            )));
              }),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          IconBtnWithCounter(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            notifyHomeScreen: notifyHomeScreen,
                          )));
            },
            //press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    Key key,
    this.notifyHomeScreen,
  }) : super(key: key);

  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth * 0.6,
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.greenAccent.withOpacity(1),
              kPrimaryColor.withOpacity(1),
              Color(0xff34783b),
            ],
          ),
        ),
        child: Material(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => showSearch(
              context: context,
              delegate: SearchedShopData(notifyHomeScreen: notifyHomeScreen)),
          child: Container(
            width: SizeConfig.screenWidth * 0.55,
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                child: Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(5),
                ),
                Text(
                  "Search nearby shops",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(15), height: 1),
                ),
              ],
            )),
          ),
        )));
  }
}
