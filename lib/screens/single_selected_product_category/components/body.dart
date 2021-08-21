import 'package:flutter/material.dart';
import 'package:grojha/Objects/product.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/screens/single_shop/components/single_product_card.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.productCategory, this.shop, this.notifyHomeScreen}) : super(key: key);
  final String productCategory;
  final Shop shop;
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    List<Product> list = [];

    for (int i = 0; i < AllProductData.productList.length; i++) {
      if (AllProductData.productList[i].productCategory == productCategory) {
        list.add(AllProductData.productList[i]);
      }
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              list.length,
              (index) => SingleProductCard(
                shop: shop,
                product: list[index],
                notifyHomeScreen: notifyHomeScreen,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight*.4,),
          ],
        ),
      ),
    );
  }
}
