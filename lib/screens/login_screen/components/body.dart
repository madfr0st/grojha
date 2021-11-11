import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grojha/Objects/current_user.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/instructions.dart';
import 'package:grojha/components/utils.dart';
import 'package:grojha/screens/otp_screen/otp_screen.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final Set<String> errors = {};

  FirebaseAuth auth = FirebaseAuth.instance;

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  String phoneNumber;

  @override
  Widget build(BuildContext context) {

    phoneNumber = Provider.of<CurrentUser>(context,listen: false).phoneNumber;
    phoneNumber = "";

    return Scaffold(
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  Instructions.heading(text: "Login With Phone Number", color: Colors.black),
                  SizedBox(
                    height: getProportionateScreenWidth(30),
                  ),
                  buildPhoneNumberFormField(),
                  SizedBox(
                    height: getProportionateScreenWidth(20),
                  ),
                  Utils.showError(set: errors),
                  const Spacer(),
                  DefaultButton(
                    text: "Continue",
                    press: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        phoneNumber = "+91" + phoneNumber;
                        Provider.of<CurrentUser>(context,listen: false).phoneNumber = phoneNumber;
                        Navigator.pushNamed(context, OtpScreen.routeName);
                     }
                   },
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(40),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters : [FilteringTextInputFormatter.digitsOnly],
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Phone number must be 10 digits.");
        }
        return;
      },
      validator: (value) {
        if (value.isEmpty || value.length != 10) {
          addError(error: "Phone number must be 10 digits.");
          return "";
        }
        return null;
      },
      maxLength: 10,
      decoration: InputDecoration(
        prefixText: "+91 ",
        prefixStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: getProportionateScreenWidth(14)),
        labelText: "Phone Number",
        //hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const Icon(Icons.phone,color: kPrimaryColor,),
      ),
    );
  }
}
