import 'package:flutter/material.dart';
import 'package:grojha/screens/single_selected_shop_category/components/custom_floating_button.dart';

import '../../constants.dart';
import 'components/body.dart';

class SingleSelectedShopCategory extends StatelessWidget {
  const SingleSelectedShopCategory({Key key, this.selectedCategory}) : super(key: key);

  static String routeName = "/single_selected_screen";

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$selectedCategory",style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(selectedCategory: selectedCategory),
      floatingActionButton: CustomFloatingButton(),
    );
  }
}
