import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/business_logic/FCM.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/business_logic/get_notifications.dart';
import 'package:grojha/components/coustom_bottom_nav_bar.dart';
import 'package:grojha/enums.dart';
import 'package:grojha/screens/home/components/home_header.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import 'package:grojha/size_config.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    CartItemCount.init();
    PlaceOrderVariables();
    FCM.init();
    GetNotifications();
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
