import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/single_selected_product_category/components/custom_floating_button.dart';

import '../../constants.dart';
import 'components/body.dart';

class SingleSelectedProductCategory extends StatelessWidget {
  const SingleSelectedProductCategory({Key key, this.productCategory, this.shop}) : super(key: key);

  static String routeName = "/single_selected_product_category_screen";
  final String productCategory;
  final Shop shop;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productCategory,style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(productCategory: productCategory,shop: shop,),
      floatingActionButton: CustomFloatingButton(shop: shop),
    );
  }
}
