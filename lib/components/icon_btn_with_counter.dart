import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grojha/business_logic/cart_item_count.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final Icon icon;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
          if (CartItemCount.cartItemCount != 0)
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
                ),
                child: Center(
                  child: Text(
                    "${CartItemCount.cartItemCount}",
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
        ],
      ),
    );
  }
}
