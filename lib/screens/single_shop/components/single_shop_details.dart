import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SingleShopDetails extends StatelessWidget {
  const SingleShopDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 5),
      height: getProportionateScreenWidth(100),
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(3, 3), // changes position of shadow
        ),
      ], color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              height: getProportionateScreenWidth(77),
              width: getProportionateScreenWidth(77),
              alignment: Alignment.center,
              color: Colors.grey.shade300,
              child: Container(
                height: getProportionateScreenWidth(75),
                width: getProportionateScreenWidth(75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Image.asset("assets/images/tshirt.png"),
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(15),
          ),
          Container(
            // color: Colors.redAccent,
            height: getProportionateScreenWidth(100),
            width: getProportionateScreenWidth(200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: getProportionateScreenWidth(40),
                  //color: Colors.green,
                  child: Text(
                    "Grojha",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        //fontStyle: FontStyle.italic,
                        fontSize: getProportionateScreenWidth(16),
                        height: 1.2),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: getProportionateScreenWidth(20),
                    //color: Colors.green,
                    child: Text(
                      "Grocery",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          height: 1,
                          fontSize: getProportionateScreenWidth(15)),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: getProportionateScreenWidth(35),
                    //color: Colors.green,
                    child: Text(
                      "DDU sector 3, house no 36, Raipur",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                          fontSize: getProportionateScreenWidth(12)),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
