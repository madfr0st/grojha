import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/components/notification_btn_with_counter.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/complete_profile/complete_profile_screen.dart';
import 'package:grojha/screens/notification/notification_screen.dart';
import 'package:grojha/screens/profile/profile_screen.dart';
import 'package:grojha/screens/searched_data/searched_shop_data.dart';
import 'package:share/share.dart';

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
          SizedBox(width: getProportionateScreenWidth(10),),
          Container(
            height: getProportionateScreenWidth(45),
            child:Image.asset("assets/images/grojhalogo big.png"),
          ),
          Spacer(),
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
          buildShareButton(press: () {
            // Share.share("https://play.google.com/store/apps/details?id=com.grojha.grojha");
            Share.share(
              "*Grojha* is a platform where you can order products in more than 20 categories from nearby local stores and get them delivered to your doorstep within 20-30 minutes.\n\nDownload the app & order now!! \n\nhttps://play.google.com/store/apps/details?id=com.grojha.grojha\n\nIn case if the above link does not work then please search *\"Grojha\"* in the Google Play Store.",
            );
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
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
        ],
      ),
    );
  }

  Container buildShareButton({
    GestureTapCallback press,
  }) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      height: getProportionateScreenWidth(45),
      width: getProportionateScreenWidth(45),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        shape: BoxShape.circle,
      ),
      child: Container(
          alignment: Alignment.center,
          height: getProportionateScreenWidth(45),
          width: getProportionateScreenWidth(45),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(1000),
            child: InkWell(
              borderRadius: BorderRadius.circular(1000),
              onTap: press,
              child: Container(
                alignment: Alignment.center,
                height: getProportionateScreenWidth(45),
                width: getProportionateScreenWidth(45),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: SvgPicture.asset(
                  "assets/icons/share.svg",
                  color: Colors.black,
                  width: getProportionateScreenWidth(18),
                  height: getProportionateScreenWidth(18),
                ),
              ),
            ),
          )),
    );
  }
}
