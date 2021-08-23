

import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';



class PhoneNumberSignInScreen extends StatelessWidget {
  const PhoneNumberSignInScreen({Key key}) : super(key: key);

  static String routeName = "/phone_number_sign_in_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(
            color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,

      ),
      body: Body(),
    );
  }
}


