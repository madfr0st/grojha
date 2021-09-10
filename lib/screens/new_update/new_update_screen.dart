import 'package:flutter/material.dart';
import 'package:grojha/size_config.dart';

import 'components/body.dart';

class NewUpdateScreen extends StatelessWidget {
  const NewUpdateScreen({Key key}) : super(key: key);

  static String routeName = "/new_update_screen";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
