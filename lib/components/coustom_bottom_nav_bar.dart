import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:grojha/screens/orders/orders_screen.dart';
import 'package:grojha/screens/profile/profile_screen.dart';
import 'package:grojha/screens/searched_data/searched_shop_data.dart';
import 'package:grojha/screens/single_shop/single_shop.dart';
import 'package:grojha/size_config.dart';

import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: getProportionateScreenWidth(50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, HomeScreen.routeName);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: MenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                            color: MenuState.home == selectedMenu
                                ? kPrimaryColor
                                : inActiveIconColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: SearchedShopData());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: MenuState.search == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                            color: MenuState.search == selectedMenu
                                ? kPrimaryColor
                                : inActiveIconColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, OrdersScreen.routeName);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.backpack_outlined,
                        color: MenuState.orders == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                            color: MenuState.orders == selectedMenu
                                ? kPrimaryColor
                                : inActiveIconColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, ProfileScreen.routeName);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: MenuState.profile == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                            color: MenuState.profile == selectedMenu
                                ? kPrimaryColor
                                : inActiveIconColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
