import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/components/custom_surfix_icon.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/components/event_status.dart';
import 'package:grojha/components/form_error.dart';
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

  @override
  Widget build(BuildContext context) {
    if(widget.appUser!=null){
      userName = widget.appUser.userName;
      userAddress = widget.appUser.userAddress;
      userPhoneNumber = widget.appUser.userPhoneNumber;
    }

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
          Instructions.banner_1("We are currently active in Kolkata.", kPrimaryColor),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Update Profile",
            press: () {
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                _updateProfile();
              }

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
        "Item will be delivered at this given address.\nSo, add some landmark to make it easy for delivery partner to find you.",
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
      initialValue: userAddress,
      onSaved: (newValue) => userAddress = newValue,
      onChanged: (value) {
        userAddress = value;
        if (value.isNotEmpty) {
          removeError(error: "Enter your address.");
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter your address.");
          return "";
        }
        return null;
      },
      maxLength: 1000,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address.",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on_outlined,color: kPrimaryColor,),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      initialValue: userName,
      onSaved: (newValue) => userName = newValue,
      onChanged: (value) {
        userName = value;
        if (value.isNotEmpty) {
          removeError(error: "Enter your name.");
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter your name.");
          return "";
        }
        return null;
      },
      maxLength: 100,
      decoration: InputDecoration(
          labelText: "Name",
          hintText: "Enter your full name",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.face_outlined,color: kPrimaryColor,)),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: userPhoneNumber,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => userPhoneNumber = newValue,
      onChanged: (value) {
        userPhoneNumber = value;
        if (value.isNotEmpty) {
          removeError(error: "Enter Contact Number.");
          if(value.length==10){
            removeError(error: "Contact Number should contain 10 digits.");
          }
          return "";
        }
        return null;
      },
      validator: (value) {
        if(value.isNotEmpty && value.length!=10){
          addError(error: "Contact Number should contain 10 digits.");
          return "";
        }
        if (value.isEmpty) {
          addError(error: "Enter Contact Number.");
          return "";
        }
        return null;
      },
      maxLength: 10,
      decoration: InputDecoration(
          labelText: "Contact Number",
          hintText: "Enter contact number",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone,color: kPrimaryColor,)),
    );
  }

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
        downloadUrl = "https://firebasestorage.googleapis.com/v0/b/project-red-117.appspot.com/o/defaultImages%2FDefaultShopImage.png?alt=media&token=bb7b949f-fb1b-42a4-ae24-22f3d8bd22fd";
      }
      databaseReference.child("info").set({
        "userName": userName,
        "userPincode": "700001",
        "userAddress": userAddress,
        "userImage": downloadUrl,
        "userPhoneNumber": userPhoneNumber,
      });

      EventStatus(context: context,popScreen: 2).success();
    } else {
      EventStatus(context: context,popScreen: 1).failed();
      print("error while updating profile");
    }
  }


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


}
