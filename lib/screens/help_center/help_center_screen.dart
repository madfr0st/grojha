import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key key}) : super(key: key);

  static String routeName = "/help_center_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Help Center", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Body(),
    );
  }
}
