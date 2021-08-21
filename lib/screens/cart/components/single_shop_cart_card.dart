import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/place_order_screen.dart';

import '../../../size_config.dart';

class SingleShopCartCard extends StatelessWidget {
  const SingleShopCartCard(
      {Key key,
      this.cartTotalCost,
      this.index,
      this.cartUniqueProducts,
      this.shop, this.notifyHomeScreen})
      : super(key: key);

  final Shop shop;
  final int cartUniqueProducts;
  final int cartTotalCost;
  final int index;
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.redAccent,
      Colors.lightBlueAccent,
      Colors.red,
      Colors.indigo,
      Colors.brown,
      Colors.grey,
      Colors.teal,
      Colors.pink,
      Colors.pinkAccent,
      Colors.green.shade700,
      Colors.red.shade700,
    ];

    Color color = colorList[0];

    if (index != null) {
      color = colorList[index % (colorList.length)];
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceOrderScreen(shop: shop,notifyHomeScreen: notifyHomeScreen,),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: getProportionateScreenWidth(141),
        width: double.infinity,
        //color: Colors.redAccent,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ], color: color, borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: getProportionateScreenWidth(141),
          width: double.infinity,
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: getProportionateScreenWidth(28),
                // color: Colors.tealAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${shop.shopName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        //fontStyle: FontStyle.italic,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: getProportionateScreenWidth(50),
                      height: getProportionateScreenWidth(30),
                      //color: Colors.blue,
                      child: Row(
                        children: [
                          Container(
                            height: getProportionateScreenWidth(11),
                            width: getProportionateScreenWidth(11),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Container(
                            height: getProportionateScreenWidth(11),
                            width: getProportionateScreenWidth(11),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Container(
                            height: getProportionateScreenWidth(11),
                            width: getProportionateScreenWidth(11),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: getProportionateScreenWidth(79),
                // color: Colors.tealAccent,
                padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: getProportionateScreenWidth(79),
                      width: getProportionateScreenWidth(175),
                      padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                      // color: Colors.red,
                      child: Row(children: [
                        Container(
                          height: getProportionateScreenWidth(62),
                          width: getProportionateScreenWidth(62),
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(1)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade300,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: (shop.shopImage != null)
                                ? Image.network(shop.shopImage)
                                : Image.asset("assets/images/default.jpg"),
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(10),),
                        Container(
                          //     color: Colors.redAccent,
                          height: getProportionateScreenWidth(50),
                          //width: getProportionateScreenWidth(105),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("$cartUniqueProducts Item"),
                              Text(
                                "₹ $cartTotalCost",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(15)),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      width: getProportionateScreenWidth(115),
                      height: getProportionateScreenWidth(33),
                      alignment: Alignment.center,
                      //padding: EdgeInsets.all(getProportionateScreenWidth(2)),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset:
                                  Offset(3, 3), // changes position of shadow
                            ),
                          ]),
                      child: Container(
                        width: getProportionateScreenWidth(112),
                        height: getProportionateScreenWidth(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(7),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PlaceOrderScreen(shop: shop,notifyHomeScreen: notifyHomeScreen,),

                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Order Details",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(13),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: getProportionateScreenWidth(12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: getProportionateScreenWidth(20),
                //color: Colors.tealAccent,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      shop.shopCategory,
                      style: TextStyle(
                        //color: Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
