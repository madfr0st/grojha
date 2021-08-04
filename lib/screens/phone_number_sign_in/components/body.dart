import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grojha/components/custom_surfix_icon.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(80),
              ),
              buildPhoneNumberFormField(),
              SizedBox(
                height: getProportionateScreenWidth(40),
              ),
              DefaultButton(
                text: "continue",
                press: () {
                  print(SizeConfig.phoneNumber);
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    SizeConfig.phoneNumber = "+91" + SizeConfig.phoneNumber;
                    Navigator.pushNamed(context, OtpScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters : [FilteringTextInputFormatter.digitsOnly],
      onSaved: (newValue) => SizeConfig.phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty || value.length != 10) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        //hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        prefixIcon: Container(
          alignment: Alignment.centerRight,
          width: getProportionateScreenWidth(10),
                height : getProportionateScreenWidth(10),
          //color: Colors.redAccent,
          child: Text(
            "+91 ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15),
                height: 1.2,
                color: Colors.black),
          ),

        ),
      ),
    );
  }
}
