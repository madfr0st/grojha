import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/business_logic/get_notifications.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class NotificationBtnWithCounter extends StatelessWidget {
  const NotificationBtnWithCounter({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final Icon icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        height: getProportionateScreenWidth(45),
        width: getProportionateScreenWidth(45),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(.3),
          //     spreadRadius: 1,
          //     blurRadius: 7,
          //     offset: Offset(4, 4), // changes position of shadow
          //   ),
          // ],
            shape: BoxShape.circle,
            color: kPrimaryColor
        ),
        child: Container(
            alignment: Alignment.center,
            height: getProportionateScreenWidth(45),
            width: getProportionateScreenWidth(45),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    child: icon
                ),
              ),
            )),
      ),
      if (GetNotifications.notificationCount != 0)
        Positioned(
          top: -3,
          right: 0,
          child: Container(
            height: getProportionateScreenWidth(16),
            //width: getProportionateScreenWidth(16),
            padding: EdgeInsets.fromLTRB(getProportionateScreenWidth(3), 0,
                getProportionateScreenWidth(3), 0),
            decoration: BoxDecoration(
              color: Color(0xFFFF4848),
              borderRadius: BorderRadius.circular(10000),
              border: Border.all(width: 1.5, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                "${GetNotifications.notificationCount}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(10),
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
    ]);
  }
}
