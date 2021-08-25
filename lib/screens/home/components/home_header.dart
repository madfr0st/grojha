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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                color: kSecondaryColor,
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
              color: kSecondaryColor,
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
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => showSearch(
          context: context,
          delegate: SearchedShopData(notifyHomeScreen: notifyHomeScreen)),
      child: Container(
        width: SizeConfig.screenWidth * 0.55,
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            child: Row(
          children: [
            //SizedBox(width: getProportionateScreenWidth(10),),
            Icon(
              Icons.search_outlined,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: getProportionateScreenWidth(5),
            ),
            Text(
              "Search shops",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(17), height: 1),
            ),
          ],
        )),
      ),
    );
  }
}
