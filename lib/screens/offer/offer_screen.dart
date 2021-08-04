import 'package:flutter/material.dart';
import 'package:grojha/components/coustom_bottom_nav_bar.dart';
import 'package:grojha/enums.dart';

import '../../constants.dart';
import 'components/body.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({Key key}) : super(key: key);

  static String routeName = "/offer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Offers",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.offers),
    );
  }
}
