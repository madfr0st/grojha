import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/components/cached_image.dart';
import 'package:grojha/global_variables/all_product_data.dart';
import 'package:grojha/screens/single_selected_product_category/SingleSelectedProductCategory.dart';
import 'package:grojha/size_config.dart';

import '../../../constants.dart';

class ProductCategories extends StatefulWidget {
  final Shop shop;

  const ProductCategories({
    Key key,
    this.shop,
    this.notifyHomeScreen,
  }) : super(key: key);
  final Function notifyHomeScreen;

  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  final scrollController = ScrollController();

  int _currentViewItem = 20;
  List<String> list = [];

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _loadMore();
      }
    });

    list = AllProductData.categoryList;
    list.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    if (list.length < _currentViewItem * 2) {
      _currentViewItem = (list.length / 2).floor();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> color_list = [
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.red,
      Colors.indigo,
      Colors.brown,
      Colors.amber,
      Colors.grey,
      Colors.teal,
      Colors.pink,
      Colors.amberAccent,
      Colors.lightGreenAccent,
      Colors.cyan,
      Colors.yellowAccent,
      Colors.tealAccent,
      Colors.pinkAccent,
      Colors.green.shade700,
      Colors.red.shade700,
      Colors.amber,
      Colors.grey,
    ];
    final _random = new Random();

    int size = list.length;
    if (size % 2 == 0) {
      var s = size / 2;
      size = calc_ranks(s);
      return Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  //controller: scrollController,
                  itemCount: _currentViewItem,
                  itemBuilder: (context, index) {
                    return CategoryCardRow(
                        list[index],
                        list[index + size],
                        color_list[_random.nextInt(color_list.length)],
                        color_list[_random.nextInt(color_list.length)]);
                  }),
              (_currentViewItem != list.length / 2.floor())
                  ? CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : Container(),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      );
    } else {
      var s = size / 2;
      size = calc_ranks(s);
      return Container(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  //controller: scrollController,
                  itemCount: _currentViewItem,
                  itemBuilder: (context, index) {
                    return CategoryCardRow(
                        list[index],
                        list[index + size],
                        color_list[_random.nextInt(color_list.length)],
                        color_list[_random.nextInt(color_list.length)]);
                  }),
              (_currentViewItem != list.length / 2.floor())
                  ? CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : CategoryCardRow1(list[2 * size],
                      color_list[_random.nextInt(color_list.length)]),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      );
    }
  }

  int calc_ranks(ranks) {
    return ranks.floor();
  }

  Padding CategoryCardRow(
      String name1, String name2, Color color1, Color color2) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleProductCategories(
            name: name1,
            color: color1,
            shop: widget.shop,
            notifyHomeScreen: widget.notifyHomeScreen,
          ),
          SingleProductCategories(
            name: name2,
            color: color2,
            shop: widget.shop,
            notifyHomeScreen: widget.notifyHomeScreen,
          ),
        ],
      ),
    );
  }

  Padding CategoryCardRow1(String name1, Color color1) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleProductCategories(
            name: name1,
            color: color1,
            shop: widget.shop,
            notifyHomeScreen: widget.notifyHomeScreen,
          ),
        ],
      ),
    );
  }

  void _loadMore() {
    if (_currentViewItem < list.length / 2) {
      _currentViewItem += 20;
    }
    if (_currentViewItem > list.length / 2) {
      _currentViewItem = (list.length / 2).floor();
    }
    setState(() {});
  }
}

class SingleProductCategories extends StatelessWidget {
  const SingleProductCategories({
    Key key,
    this.color,
    this.name,
    this.shop,
    this.notifyHomeScreen,
  }) : super(key: key);

  final Color color;
  final String name;
  final Shop shop;
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth * .18,
      width: SizeConfig.screenWidth * .3,
      padding: EdgeInsets.all(getProportionateScreenWidth(2)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        //color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(1),
            color.withOpacity(0.2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        height: SizeConfig.screenWidth * .18,
        width: SizeConfig.screenWidth * .3,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: SizeConfig.screenWidth * .18,
                width: SizeConfig.screenWidth * .3,
              ),
              Container(
                height: SizeConfig.screenWidth * .18,
                width: SizeConfig.screenWidth * .3,
                child: CachedNetworkImage(
                  imageUrl: AllProductData.categoryImageMap[name],
                  imageBuilder: (context,image){
                    return Container(
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.white.withOpacity(.2), BlendMode.lighten),
                          image: image,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              // Container(
              //   decoration: new BoxDecoration(
              //     color: const Color(0xff7c94b6),
              //     image: new DecorationImage(
              //       fit: BoxFit.cover,
              //       colorFilter: new ColorFilter.mode(
              //           Colors.white.withOpacity(0.2), BlendMode.lighten),
              //     ),
              //   ),
              // ),
              Container(
                height: SizeConfig.screenWidth * .18,
                width: SizeConfig.screenWidth * .3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.25),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleSelectedProductCategory(
                            productCategory: name,
                            shop: shop,
                            notifyHomeScreen: notifyHomeScreen,
                          ),
                        ));
                  },
                  child: Container(
                    height: SizeConfig.screenWidth * .18,
                    width: SizeConfig.screenWidth * .3,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //Text(text, textAlign: TextAlign.cente
    );
  }
}
