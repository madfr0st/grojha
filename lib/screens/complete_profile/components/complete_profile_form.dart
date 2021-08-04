import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/components/custom_surfix_icon.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/grad_button.dart';
import 'package:grojha/screens/home/home_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../complete_profile_screen.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key key, this.appUser}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();

  final AppUser appUser;
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String userName = "";
  String userPhoneNumber = "";
  String userAddress = "";

  void _updateProfile() async {
    if (userName == null || userName.length == 0) {
      userName = widget.appUser.userName;
    }

    if (userAddress == null || userAddress.length == 0) {
      userAddress = widget.appUser.userAddress;
    }

    if (userPhoneNumber == null || userPhoneNumber.length == 0) {
      userPhoneNumber = widget.appUser.userPhoneNumber;
    }

    if (userName != null &&
        userName.length != 0 &&
        userAddress != null &&
        userAddress.length != 0 &&
        userPhoneNumber != null &&
        userPhoneNumber.length == 10) {
      var downloadUrl;

      final _firebaseStorage = FirebaseStorage.instance;
      String id = FirebaseAuth.instance.currentUser.uid;
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.reference().child("users").child(id);

      if (CompleteProfileScreen.userImageFile != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('userImages/$id/userImage')
            .putFile(CompleteProfileScreen.userImageFile);

        downloadUrl = await snapshot.ref.getDownloadURL();

        databaseReference.child("info").set({
        });
      } else if (widget.appUser.userImage != null) {
        downloadUrl = widget.appUser.userImage;
        databaseReference.child("info").set({
        });
      } else {
        downloadUrl = "https://picsum.photos/250?image=9";
      }
      databaseReference.child("info").set({
        "userName": userName,
        "userPincode": "700001",
        "userAddress": userAddress,
        "userImage": downloadUrl,
        "userPhoneNumber": userPhoneNumber,
      });

      _success();
    } else {
      _error();
      print("error while updating profile");
    }
  }

  void _error() {
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
            height: getProportionateScreenWidth(100),
            child: Center(
              child: GradButton(
                name: "Some fields are empty",
                color1: Colors.redAccent,
                color2: Colors.redAccent,
                press: () {},
              ),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
      //pop dialog
    });
  }

  void _success() {
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
            height: getProportionateScreenWidth(100),
            child: Center(
              child: GradButton(
                name: "Updated",
                color1: Colors.greenAccent,
                color2: Colors.greenAccent,
                press: () {},
              ),
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pop(context);
      //pop dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          addressDiscription(),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Update Profile",
            press: () {
              print("updating profile");
              _updateProfile();
            },
          ),
        ],
      ),
    );
  }

  Container addressDiscription() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        "We are currently active in Kolkata.\nCurrently default pincode will be 700001.",
        style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(12),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      maxLines: 8,
      onSaved: (newValue) => userAddress = newValue,
      onChanged: (value) {
        userAddress = value;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "${widget.appUser.userAddress}",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        userName = value;
        return null;
      },
      decoration: InputDecoration(
          labelText: "Name",
          hintText: "${widget.appUser.userName}",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.face_outlined)),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => userPhoneNumber = newValue,
      onChanged: (value) {
        userPhoneNumber = value;
        return null;
      },
      //initialValue: widget.appUser.userPhoneNumber,
      decoration: InputDecoration(
          labelText: "Contact Number",
          hintText: "${widget.appUser.userPhoneNumber}",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone)),
    );
  }
}
