import 'package:flutter/material.dart';
import 'package:grojha/screens/searched_data/searched_shop_data.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    Key key,
    this.notifyHomeScreen,
  }) : super(key: key);

  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth ,
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
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