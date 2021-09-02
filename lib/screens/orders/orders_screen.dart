import 'package:flutter/material.dart';
import 'package:grojha/components/coustom_bottom_nav_bar.dart';
import 'package:grojha/constants.dart';
import 'package:grojha/enums.dart';
import 'package:grojha/size_config.dart';

import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  static String routeName = "/orders_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),

      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }
}
