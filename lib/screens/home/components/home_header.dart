import 'package:flutter/material.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/profile/profile_screen.dart';
import 'package:grojha/screens/searched_data/searched_shop_data.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeSearchField(),
          Spacer(),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          IconBtnWithCounter(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: kSecondaryColor,
            ),
            numOfitem: 3,
            press: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            //press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          accountButton(context),
          //SearchField(),
        ],
      ),
    );
  }
}

Container accountButton(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    height: getProportionateScreenWidth(49),
    width: getProportionateScreenWidth(49),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(4, 4), // changes position of shadow
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.purple.withOpacity(1),
          Colors.red.withOpacity(1),
        ],
      ),
      shape: BoxShape.circle,
    ),
    child: Container(
      alignment: Alignment.center,
      //padding: EdgeInsets.all(5),
      height: getProportionateScreenWidth(44),
      width: getProportionateScreenWidth(44),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: getProportionateScreenWidth(44),
            width: getProportionateScreenWidth(44),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_circle_outlined, color: kSecondaryColor),
          ),
        )
        ,
      )
      ,
    )
    ,
  );
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => showSearch(context: context, delegate: SearchedShopData()),
      child: Container(
        width: SizeConfig.screenWidth * 0.5,
        padding: EdgeInsets.all(10),
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
                  "Search ",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(17), height: 1),
                ),
              ],
            )),
      ),
    );
  }
}
