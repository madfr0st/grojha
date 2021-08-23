import 'package:flutter/material.dart';
import 'package:grojha/main.dart';

import '../../constants.dart';
import 'components/body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  static String routeName = "/notification_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body:Body(),
    );
  }
}
