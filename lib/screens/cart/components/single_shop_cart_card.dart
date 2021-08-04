import 'package:flutter/material.dart';
import 'package:grojha/Objects/shop.dart';
import 'package:grojha/screens/place_order/place_order_screen.dart';

import '../../../size_config.dart';

class SingleShopCartCard extends StatelessWidget {
  const SingleShopCartCard(
      {Key key,
      this.cartTotalCost,
      this.index,
      this.cartUniqueProducts, this.shop})
      : super(key: key);

  final Shop shop;
  final int cartUniqueProducts;
  final int cartTotalCost;
  final int index;

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

    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: getProportionateScreenWidth(143),
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
        height: getProportionateScreenWidth(143),
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
                    shop.shopName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      //fontStyle: FontStyle.italic,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                  Text(
                    shop.shopCategory,
                    style: TextStyle(
                      //color: Colors.grey,
                      fontWeight: FontWeight.w800,
                      fontSize: getProportionateScreenWidth(14),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: getProportionateScreenWidth(70),
              // color: Colors.tealAccent,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: getProportionateScreenWidth(70),
                    width: getProportionateScreenWidth(180),
                    // color: Colors.red,
                    child: Row(children: [
                      Container(
                        height: getProportionateScreenWidth(62),
                        width: getProportionateScreenWidth(62),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        child: Container(
                          height: getProportionateScreenWidth(60),
                          width: getProportionateScreenWidth(60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(shop.shopImage),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        //     color: Colors.redAccent,
                        height: getProportionateScreenWidth(50),
                        width: getProportionateScreenWidth(105),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              cartUniqueProducts.toString() + " ITEMS",
                            ),
                            Text(
                              "₹ $cartTotalCost",
                              //textAlign: TextAlign.left,
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
                    height: getProportionateScreenWidth(28),
                    width: getProportionateScreenWidth(70),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFDCDBDB)),
                    child: Text(
                      "COD",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.w900,
                          color: Colors.indigo),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: getProportionateScreenWidth(29),
              //  color: Colors.tealAccent,
              child: Row(
                children: [
                  Container(
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenHeight(30),
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
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      width: getProportionateScreenWidth(80),
                      height: getProportionateScreenWidth(25),
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Container(
                        width: getProportionateScreenWidth(78),
                        height: getProportionateScreenWidth(23),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Material(
                          color: Color(0xffd2d1d1),
                          borderRadius: BorderRadius.circular(6),
                          elevation: 15,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaceOrder(
                                    shop : shop
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: getProportionateScreenWidth(13),
                                      fontWeight: FontWeight.w600,
                                      height: 1.2),
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
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
