import 'package:flutter/material.dart';

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
    );
  }
}
