import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:grojha/screens/home/home_screen.dart';


import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final String phone = SizeConfig.phoneNumber;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color(0xffe2e1e1),
    borderRadius: BorderRadius.circular(7.0),
    border: Border.all(
        color: kPrimaryColor,
        width: getProportionateScreenWidth(2)
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("OTP Verification", style: TextStyle(
            color: Colors.black
        ),),
        elevation: 15,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                SizeConfig.phoneNumber,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(20),),
          buildTimer(),
          SizedBox(height: getProportionateScreenWidth(20),),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              eachFieldWidth: getProportionateScreenWidth(45),
              eachFieldHeight: getProportionateScreenWidth(45),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      FirebaseMessaging.instance.getToken().then((token) {
                        FirebaseDatabase.instance.reference().child("users")
                            .child(value.user.uid).child("deviceToken")
                            .set(token);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) =>
                                HomeScreen()), (Route<dynamic> route) => false);
                      });
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: SizeConfig.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              FirebaseMessaging.instance.getToken().then((token) {
                FirebaseDatabase.instance.reference().child("users")
                    .child(value.user.uid).child("deviceToken")
                    .set(token);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) =>
                        HomeScreen()), (Route<dynamic> route) => false);
              });
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
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
        timeout: Duration(seconds: 120));
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
        Text("This code will expired in "),
        TweenAnimationBuilder(
            tween: Tween(begin: 300.0, end: 0.0),
            duration: Duration(seconds: 300),
            builder: (_, value, child) {
              int tSec = value.toInt();
              int min = (tSec / 60).floor();
              int sec = tSec % 60;

              return Text(
                "0$min:$sec",
                style: TextStyle(color: kPrimaryColor),
              );
            }
        ),
      ],
    );
  }
}
