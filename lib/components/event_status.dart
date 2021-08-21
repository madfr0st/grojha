import 'package:flutter/material.dart';

import '../size_config.dart';

class EventStatus {

  int popScreen;
  BuildContext context;

  EventStatus({this.context,this.popScreen});

  void success(){

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            width: double.infinity,
            height: getProportionateScreenWidth(300),
            child: Center(
              child: Image.asset("assets/images/success.jpg"),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () {
      for(int i=0;i<popScreen;i++){
        try {
          Navigator.pop(this.context);
        }
        catch(e){
          print(e);
        }
      }
      //pop dialog
    });
  }

  void failed(){
    showDialog(
      context: context,
      barrierDismissible: false ,
      builder: (BuildContext context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: Container(
            width: double.infinity,
            height: getProportionateScreenWidth(300),
            child: Center(
              child: Image.asset("assets/images/failed.jpg"),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds:1), () {
      for(int i=0;i<popScreen;i++){
        Navigator.pop(this.context);
      }
      //pop dialog
    });
  }

}
