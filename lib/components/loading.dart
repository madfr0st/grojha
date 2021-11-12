import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Loading {
  static Container loadingGrojha() {
    return Container(
        child:EasyLoader(
          image: AssetImage('assets/images/grojhaLoading.png'),
          backgroundColor: Colors.white,
          //iconColor: kPrimaryColor,
        )
    );
  }


  static Widget loadingMainGrojha() {
    return Directionality(
      textDirection: TextDirection.rtl,
        child:EasyLoader(
          image: AssetImage('assets/images/grojhaLoading.png'),
          backgroundColor: Colors.white,
          //iconColor: kPrimaryColor,
        ),
    );
  }
}
