import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/current_user.dart';
import 'package:grojha/components/instructions.dart';
import 'package:grojha/screens/home/home_screen.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../theme.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color(0xffffffff),
    borderRadius: BorderRadius.circular(7.0),
    border: Border.all(color: kPrimaryColor, width: getProportionateScreenWidth(2)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(3, 3), // changes position of shadow
      ),
    ],
  );

  final BoxDecoration selectedPinPutDecoration = BoxDecoration(
    color: const Color(0xffe2e1e1),
    borderRadius: BorderRadius.circular(7.0),
    border: Border.all(color: kPrimaryColor, width: getProportionateScreenWidth(2)),
  );

  final Container cursor = Container(
    height: getProportionateScreenWidth(10),
    width: getProportionateScreenWidth(10),
    decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
  );

  String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    _phoneNumber = Provider.of<CurrentUser>(context, listen: false).phoneNumber;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Instructions.heading(text: "OTP Verification", color: Colors.black),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Center(
              child: Text(
                _phoneNumberSeparation(_phoneNumber),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              child: Theme(
                data: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  fontFamily: "Muli",
                  appBarTheme: appBarTheme(),
                  textTheme: textTheme(),
                  //inputDecorationTheme: inputDecorationTheme(),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                child: PinPut(
                  fieldsCount: 6,
                  //disabledDecoration: ,
                  textStyle: TextStyle(fontSize: getProportionateScreenWidth(20), color: Colors.black, fontWeight: FontWeight.bold),
                  eachFieldWidth: getProportionateScreenWidth(45),
                  eachFieldHeight: getProportionateScreenWidth(45),
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: selectedPinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  cursor: cursor,
                  withCursor: true,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
                        }
                      });
                    } catch (e) {
                      FocusScope.of(context).unfocus();
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(content: Text('invalid OTP')));
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            buildTimer(),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    _phoneNumber = Provider.of<CurrentUser>(context, listen: false).phoneNumber;
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "This code will expired in ",
        ),
        TweenAnimationBuilder(
            tween: Tween(begin: 120.0, end: 0.0),
            duration: const Duration(seconds: 120),
            builder: (_, value, child) {
              int tSec = (value as double).toInt();
              int min = (tSec / 60).floor();
              int sec = tSec % 60;

              return Text(
                "0$min:$sec",
                style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              );
            }),
      ],
    );
  }

  static String _phoneNumberSeparation(String string) {
    List<String> a = string.split("");
    String ret = "";
    for (int i = 0; i < 3; i++) {
      ret += a[i];
    }
    ret += " ";
    for (int i = 3; i < 6; i++) {
      ret += a[i];
    }
    ret += " ";
    for (int i = 6; i < 9; i++) {
      ret += a[i];
    }
    ret += " ";
    for (int i = 9; i < a.length; i++) {
      ret += a[i];
    }
    return ret;
  }
}
