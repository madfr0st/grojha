import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grojha/Objects/notifications.dart';
import 'package:grojha/business_logic/FCM.dart';
import 'package:grojha/business_logic/get_notifications.dart';
import 'package:grojha/components/Instructions.dart';
import 'package:grojha/components/default_button.dart';
import 'package:grojha/screens/notification/components/single_notification_card.dart';
import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.notifyHomeScreen}) : super(key: key);
  final Function notifyHomeScreen;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("users/$uid/notifications");

    int count = 0;

    return SafeArea(
        child: FutureBuilder(
      future: databaseReference.once(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          try {
            Map<dynamic, dynamic> map = snapShot.data.value;
            GetNotifications.notificationCount = 0;
            GetNotifications.notificationList.clear();
            map.forEach((key, val) {
              GetNotifications.notificationCount++;
              GetNotifications.notificationList.add(new Notifications(
                title: val["title"],
                body: val["body"],
                time: val["time"],
              ));
            });

            GetNotifications.notificationList
                .sort((a, b) => -a.time.compareTo(b.time));

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DefaultButton(
                      text: "Clear Notifications",
                      press: () {
                        databaseReference.set({});
                        GetNotifications.notificationList.clear();
                        GetNotifications.notificationCount = 0;
                        Navigator.pop(context);
                        widget.notifyHomeScreen();
                      },
                    ),
                  ),
                  ...List.generate(
                      GetNotifications.notificationList.length,
                      (index) => SingleNotificationCard(
                            notifications:
                                GetNotifications.notificationList[index],
                          )),
                ],
              ),
            );
          } catch (e) {
            print(e);
            return Center(
              child: Instructions.banner_1("Zero notifications",kPrimaryColor),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      },
    ));
  }
}
