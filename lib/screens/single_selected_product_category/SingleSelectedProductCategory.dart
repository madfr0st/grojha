import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/business_logic/cart_item_count.dart';
import 'package:grojha/components/icon_btn_with_counter.dart';
import 'package:grojha/screens/cart/cart_screen.dart';
import 'package:grojha/screens/single_selected_product_category/components/custom_floating_button.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';




class SingleSelectedProductCategory extends StatefulWidget {
  const SingleSelectedProductCategory({Key key, this.productCategory, this.shop, this.notifyHomeScreen}) : super(key: key);

  static String routeName = "/single_selected_product_category_screen";
  final String productCategory;
  final Shop shop;
  final Function notifyHomeScreen;


  @override
  _SingleSelectedProductCategoryState createState() => _SingleSelectedProductCategoryState();
}

class _SingleSelectedProductCategoryState extends State<SingleSelectedProductCategory> {



  @override
  Widget build(BuildContext context) {

    void _refresh(){
      widget.notifyHomeScreen();
      setState(() {

      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productCategory,style: TextStyle(
            color: Colors.black
        ),),
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
      body: Body(productCategory: widget.productCategory,shop: widget.shop,notifyHomeScreen: _refresh,),
      floatingActionButton: CustomFloatingButton(shop: widget.shop,notifyHomeScreen: _refresh,),
    );
  }
}
