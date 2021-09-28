import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/app_user.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/screens/complete_profile/complete_profile_screen.dart';
import 'package:grojha/screens/place_order/components/place_order_variables.dart';
import '../../../size_config.dart';
import 'complete_profile_form.dart';
import 'header.dart';
import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .reference()
        .child("users")
        .child(uid)
        .child("info");
    String userName;
    String userPhoneNumber;
    String userAddress;
    String userImage;

    AppUser appUser;

    return SafeArea(
      child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: databaseReference.once(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                try {
                  Map<dynamic, dynamic> map = snapShot.data.value;
                  userName = map["userName"];
                  userPhoneNumber = map["userPhoneNumber"];
                  userAddress = map["userAddress"];
                  userImage = map["userImage"];

                  appUser = new AppUser(
                    userAddress: userAddress,
                    userPhoneNumber: userPhoneNumber,
                    userName: userName,
                    userImage: userImage,
                  );
                  CompleteProfileScreen.userImage = Image(
                      image: CachedNetworkImageProvider(appUser.userImage));
                } catch (e) {
                  print(e);
                  appUser = new AppUser();
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        Header(appUser: appUser),
                        SizedBox(height: getProportionateScreenWidth(20)),
                        CompleteProfileForm(appUser: appUser),
                        SizedBox(height: getProportionateScreenHeight(30)),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            },
          )),
    );
  }
}
