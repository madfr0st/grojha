import 'package:flutter/material.dart';
import 'package:grojha/main.dart';

import '../../constants.dart';
import 'components/body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key, this.notifyHomeScreen}) : super(key: key);

  static String routeName = "/notification_screen";
  final Function notifyHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),

      ),
      body:Body(notifyHomeScreen: notifyHomeScreen,),
    );
  }
}
