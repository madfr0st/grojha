import 'package:flutter/material.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/single_selected_shop_category/components/custom_floating_button.dart';
import 'package:grojha/size_config.dart';

import '../../constants.dart';
import 'components/body.dart';

class SingleSelectedShopCategory extends StatefulWidget {
  static String routeName = "/single_selected_screen";

  final String selectedCategory;
  final Function notifyHomeScreen;

  const SingleSelectedShopCategory(
      {Key key, this.selectedCategory, this.notifyHomeScreen})
      : super(key: key);

  @override
  _SingleSelectedShopCategoryState createState() =>
      _SingleSelectedShopCategoryState();
}

class _SingleSelectedShopCategoryState
    extends State<SingleSelectedShopCategory> {
  @override
  Widget build(BuildContext context) {
    void _refresh() {
      widget.notifyHomeScreen();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.selectedCategory}",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 15,
        backgroundColor: kPrimaryColor,
        actions: [
          Container(
            margin:
                EdgeInsets.fromLTRB(0, 0, getProportionateScreenWidth(20), 0),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: IconBtnWithCounter(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: kSecondaryColor,
              ),

              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      notifyHomeScreen: _refresh,
                    ),
                  ),
                );
              },
              //press: () => Navigator.pushNamed(context, CartScreen.routeName),
            ),
          )
        ],
      ),
      body: Body(
        selectedCategory: widget.selectedCategory,
        notifyHomeScreen: _refresh,
      ),
      floatingActionButton: CustomFloatingButton(notifyHomeScreen: _refresh,),
    );
  }
}
