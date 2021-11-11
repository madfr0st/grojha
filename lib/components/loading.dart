import 'package:easy_loader/easy_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Loading {
  static Widget loadingGrojha() {
    return const EasyLoader(
      image: AssetImage('assets/images/grojhaLoading.png'),
      backgroundColor: Colors.white,
      //iconColor: kPrimaryColor,
    );
  }
}
